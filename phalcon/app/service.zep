/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

namespace Phalcon\App;

use Phalcon\App\Config;
use Phalcon\App\Flow;
use Phalcon\Driver\Redis\Redis;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt;
use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Logger\Adapter\File as FileAdapter;
use Phalcon\Mvc\Collection\Manager as CollectionManager;
use Phalcon\Db\Adapter\Pdo\Mysql;
use Phalcon\Http\Response\Cookies;
use Phalcon\App\Router;

//use Phalcon\Translate\Adapter\Gettext as Translator;
//use App\Plugin\Volt as VoltEngine;

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

	public service;
	private static static_service;
    private static static_url;
    private static static_crypt;
    private static static_view;
    private static static_volt;
    private static static_logger;
    private static static_cookie;
    private static static_session;
    private static static_redis;
    private static static_mysql;
    private static static_mongo;
    private static static_col_manager;

    /**
     * Constructor
     *
     */
    private function __construct()
	{
        let this->service = new FactoryDefault();
    }

    /**
     * Get service instance
     *
     * @var App\Service
     */
	public static function getInstance()
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
    public function getService()
    {
        return this->service;
    }

    /**
     * Get router
     *
     * @return App\Router
     */
    public static function getRouter()
    {
        return Router::getInstance()->getRouter();
    }

    /**
     * Get config
     *
     * @return App\Config
     */
    public static function getConfig()
    {
        return Config::getInstance()->getConfig();
    }

    /**
     * Get url service
     *
     * @return Phalcon\Mvc\Url
     */
    public static function getUrl()
    {
        if self::static_url {
            return self::static_url;
        }

        var url;

        let url = new UrlResolver();
        url->setBaseUri("/");

        let self::static_url = url;
        return url;
    }

    /**
     * Get view service
     *
     * @return Phalcon\Mvc\View
     */
    public static function getView()
    {
        if self::static_view {
            return self::static_view;
        }

        var view;
        let view = new View();

        view->setViewsDir(self::getConfig()->{"context"}->{"template"})
            ->registerEngines([
                ".volt" : function(view, service) {
                    return \Phalcon\App\Service::getVolt(view, service);
                }
            ]);

        let self::static_view = view;
        return view;
    }

    /**
     * Get volt template engine
     *
     * @return Phalcon\Mvc\View\Engine\Volt
     */
    public static function getVolt(view, di)
    {
        if self::static_volt {
            return self::static_volt;
        }

        var volt;
        let volt = new Volt(view, di);

        volt->setOptions([
                "compiledPath" : self::getConfig()->{"path"}->{"cache"},
                "compiledSeparator" : "_",
                "compileAlways" : true
            ]);

        self::setCompiler(volt->getCompiler());

        let self::static_volt = volt;
        return volt;
    }

    /**
     * Set up for compiler
     *
     * @param compiler
     */
    public static function setCompiler(compiler)
    {
        var view;
        let view = "\\Phalcon\\App\\View";

        compiler->addFilter("trans",   view . "::trans");
        compiler->addFilter("site",    view . "::site");
        compiler->addFilter("json",    view . "::json");
        compiler->addFilter("img",     view . "::img");
        compiler->addFilter("css",     view . "::css");
        compiler->addFilter("js",      view . "::js");
        compiler->addFilter("less",    view . "::less");
        compiler->addFilter("coffee",  view . "::coffee");
    }

    /**
     * Get session service
     *
     * @return Phalcon\Session\Adapter\Files
     */
    public static function getSession()
    {
        if self::static_session {
            return self::static_session;
        }

        var session;
        let session = new SessionAdapter();

        let self::static_session = session;
        return session;
    }

    /**
     * Get cookies service
     *
     * @return Phalcon\Session\Adapter\Files
     */
    public static function getCookie()
    {
        if self::static_cookie {
            return self::static_cookie;
        }

        var cookies;
        let cookies = new Cookies();
        cookies->useEncryption(true);

        let self::static_cookie = cookies;
        return cookies;
    }

    /**
     * Get logger
     *
     * @return Phalcon\Logger\Adapter\File
     */
    public static function getLogger()
    {
        if self::static_logger {
            return self::static_logger;
        }

        var logger;
        let logger = new FileAdapter(self::getConfig()->path->log);

        let self::static_logger = logger;
        return logger;
    }

    /**
     * Get MySQL service
     *
     * @return Phalcon\Db\Adapter\Pdo\Mysql
     */
    public static function getMySQL()
    {
        if self::static_mysql {
            return self::static_mysql;
        }

        var config, mysql;
        let config = self::getConfig()->database->mysql;

        let mysql = new Mysql([
            "host"    : config->host,
            "port"    : config->port,
            "username": config->username,
            "password": config->password,
            "dbname"  : config->dbname,
            "options" : [
                // PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
                1002 : "SET NAMES " . config->charset
            ]
        ]);

        let self::static_mysql = mysql;
        return mysql;
    }

    /**
     * Get MongoDB service
     *
     * @return \MongoClient
     */
    public static function getMongoDB()
    {
        if self::static_mongo {
            return self::static_mongo;
        }

        var mongo, config;
        let config = self::getConfig()->database->mongo;

        if config->password {
            let config->config = ":" . config->password;
        }

        if config->port {
            let config->port = ":" . config->port;
        }

        if config->dbname {
            let config->dbname = "/" . config->dbname;
        }

        // TODO
        // Add username and password to Mongo URI
        let mongo = new \MongoClient(
                        "mongodb://" . config->host . config->port . config->dbname
                    );

        let self::static_mongo = mongo;
        return mongo;
    }

    /**
     * Get Collection manager service
     *
     * @return Phalcon\Mvc\Collection\Manager
     */
    public static function getCollectionManager()
    {
        if self::static_col_manager {
            return self::static_col_manager;
        }

        var col_manager;
        let col_manager = new CollectionManager();

        let self::static_col_manager = col_manager;
        return col_manager;
    }

    /**
     * Get Redis services
     *
     * @return Redis
     */
    public static function getRedis()
    {
        if self::static_redis {
            return self::static_redis;
        }

        var redis = [];

        let redis = new Redis();
        redis->connect();

        let self::static_redis = redis;
        return redis;
    }
}