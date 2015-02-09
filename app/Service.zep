/*
 +--------------------------------------------------------------------------+
 | Penlook Project                                                          |
 +--------------------------------------------------------------------------+
 | Copyright (c) 2015 Penlook Development Team                              |
 +--------------------------------------------------------------------------+
 |                                                                          |
 | This program is free software: you can redistribute it and/or modify     |
 | it under the terms of the GNU Affero General Public License as           |
 | published by the Free Software Foundation, either version 3 of the       |
 | License, or (at your option) any later version.                          |
 |                                                                          |
 | This program is distributed in the hope that it will be useful, but      |
 | WITHOUT ANY WARRANTY; without even the implied warranty of               |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
 | GNU Affero General Public License for more details.                      |
 |                                                                          |
 | You should have received a copy of the GNU Affero General Public License |
 | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
 |                                                                          |
 +--------------------------------------------------------------------------+
 |   Authors: Loi Nguyen  <loint@penlook.com>                               |
 |            Tin Nguyen  <tinntt@penlook.com>                              |
 |            Nam Vo      <namvh@penlook.com>                               |
 +--------------------------------------------------------------------------+
*/

namespace App;

use Phalcon\Mvc\View;
use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use App\Plugin\Volt as VoltEngine;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Mvc\Collection\Manager as CollectionManager;
use Phalcon\Translate\Adapter\Gettext as Translator;
use Phalcon\Db\Adapter\Pdo\Mysql;

/**
 * App Service
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Service
{
	/**
     * Application Service
     *
     * @var Phalcon\DI\FactoryDefault
     */
	public service;

    /**
     * Service Instance
     *
     * @var Phalcon\Service
     */
	private static static_service;

    /**
     * Constructor
     *
     */
    private inline function __construct()
	{
        let this->service = new FactoryDefault();
    }

    /**
     * Get service instance
     *
     * @var App\Service
     */
	public inline static function getInstance()
    {
        if ! self::static_service {
            let self::static_service = new Service();
        }

        return self::static_service;
    }

    /**
     * Get service
     *
     * @return Phalcon\DI\FactoryDefault
     */
    public inline function getService()
    {
        return this->service;
    }

    /**
     * Get router
     *
     * @return App\Router
     */
    public inline static function getRouter()
    {
        return Router::getInstance()->getRouter();
    }

    /**
     * Get path
     *
     * @return App\Path
     */
    public inline static function getPath()
    {
        // NEED TO DELETE
    }

    /**
     * Get config
     *
     * @return App\Config
     */
    public inline static function getConfig()
    {
        return Config::getInstance()->getConfig();
    }

    /**
     * Get url service
     *
     * @return Phalcon\Mvc\Url
     */
    public inline static function getUrl()
    {
        var url;

        let url = new UrlResolver();
        url->setBaseUri("/");

        return url;
    }

    /**
     * Get view service
     *
     * @return Phalcon\Mvc\View
     */
    public inline static function getView()
    {
        var view;
        let view = new View();

        view->setViewsDir(self::getConfig()->app->view)
            ->registerEngines([
                ".volt" : function(view, service) {
                    return Service::getVolt(view, service);
                }
            ]);

        return view;
    }

    /**
     * Get volt template engine
     *
     * @return Phalcon\Mvc\View\Engine\Volt
     */
    public inline static function getVolt(view, di)
    {
        var volt;
        let volt = new VoltEngine(view, di);

        volt->setOptions([
                "compiledPath" : self::getConfig()->path->cache,
                "compiledSeparator" : "_",
                "compileAlways" : true
            ]);

        self::setCompiler(volt->getCompiler());

        return volt;
    }

    /**
     * Set up for compiler
     *
     * @param compiler
     */
    public inline static function setCompiler(compiler)
    {
        compiler->addFilter("trans",   "\\App\\View::trans");
        compiler->addFilter("site",    "\\App\\View::site");
        compiler->addFilter("json",    "\\App\\View::json");
        compiler->addFilter("img",     "\\App\\View::img");
        compiler->addFilter("css",     "\\App\\View::css");
        compiler->addFilter("js",      "\\App\\View::js");
        compiler->addFilter("less",    "\\App\\View::less");
        compiler->addFilter("coffee",  "\\App\\View::coffee");
    }

    /**
     * Get session service
     *
     * @return Phalcon\Session\Adapter\Files
     */
    public inline static function getSession()
    {
        return new SessionAdapter();
    }

    /**
     * Get cookies service
     *
     * @return Phalcon\Session\Adapter\Files
     */
    public inline static function getCookie()
    {
        var cookies;
        let cookies = new \Phalcon\Http\Response\Cookies();
        cookies->useEncryption(true);
        return cookies;
    }

    /**
     * Get cookies service
     *
     * @return Phalcon\Session\Adapter\Files
     */
    public inline static function getCrypt()
    {
        var crypt;
        let crypt = new \Phalcon\Crypt();
        crypt->setKey("#1dj8$=dp?.ak//j1V$");
        return crypt;
    }

    /**
     * Get google cloud storage
     *
     * @return App\Storage
     */
    public inline static function getStorage()
    {
        return Storage::getInstance()->getStorage();
    }

    /**
     * Get MySQL service
     *
     * @return Phalcon\Db\Adapter\Pdo\Mysql
     */
    public inline static function getMySQL()
    {
        var mysql;
        let mysql = self::getConfig()->database->mysql;

        return new Mysql([
            "host"    : mysql->host,
            "port"    : mysql->port,
            "username": mysql->username,
            "password": mysql->password,
            "dbname"  : mysql->dbname,
            "options" : [
                // PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
                1002 : "SET NAMES " . mysql->charset
            ]
        ]);
    }

    /**
     * Get MongoDB service
     *
     * @return \MongoClient
     */
    public inline static function getMongoDB()
    {
        var mongo;
        let mongo = self::getConfig()->database->mongo;

        if mongo->password {
            let mongo->password = ":" . mongo->password;
        }

        if mongo->port {
            let mongo->port = ":" . mongo->port;
        }

        if mongo->dbname {
            let mongo->dbname = "/" . mongo->dbname;
        }

        // TODO
        // Add username and password to Mongo URI
        return new \MongoClient(
                        "mongodb://" . mongo->host . mongo->port . mongo->dbname
                    );
    }

    /**
     * Get Collection manager service
     *
     * @return Phalcon\Mvc\Collection\Manager
     */
    public inline static function getCollectionManager()
    {
        return new CollectionManager();
    }

    /**
     * Get Redis services
     *
     * @return \Redis
     */
    public inline static function getRedis()
    {
        var redis, config;
        let redis = new \Redis();
        redis->connect("localhost", 6379);
        return redis;
    }
}