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

use Phalcon\Mvc\Application;

/**
 * App Configuration
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class App
{

    /**
     * Debug Mode
     */
    const DEBUG    = 0;

    /**
     * Production mode
     */
    const RELEASE  = 1;

    /**
     * Maintain mode
     */
    const MAINTAIN = 2;

    /**
     * Configuration
     *
     * @var App\Config
     */
    private config;

    /**
     * Service
     *
     * @var App\Service
     */
    private service;

    /**
     * Loader
     *
     * @var App\Loader
     */
    private loader;

    /**
     * Service
     *
     * @var Phalcon\Mvc\Application
     */
    private application;

    /**
     * Temporary property
     */
    public debug;

    /**
     * Mode
     *
     * @var int
     */
    public mode;

    /**
     * Application Constructor
     *
     */
    public inline function __construct()
    {
        let this->config = Config::getInstance();
    }

    /**
     * Set mode
     * Switch mode for application
     *
     * @param int mode
     */
    public inline function setMode(mode)
    {
        let this->mode = mode;
        return this;
    }

    /**
     * Get mode
     * Retrieve current mode of application
     *
     * @return int
     */
    public inline function getMode()
    {
        return this->mode;
    }

    /**
     * Get service
     * Retrieve current service container
     *
     * @return Phalcon\DI\FactoryDefault
     */
    public inline function getService()
    {
        return Service::getInstance()->getService();
    }

    /**
     * Set multiple services
     *
     * @return App\App
     */
    public inline function setServices(callback)
    {
        call_user_func_array(callback, [ this->getListServices() ]);
        return this;
    }

    /**
     * Set single service
     *
     * @return App\App
     */
    public inline function setService(name, closure)
    {
        this->getService()->set(name, closure);
        return this;
    }

    /**
     * Get list services
     * Retrieve all service are already registered
     *
     * @return array
     */
    public inline function getListServices()
    {
        return [
            "url"               : Service::getUrl(),
            "path"              : Service::getPath(),
            "config"            : Service::getConfig(),
            "router"            : Service::getRouter(),
            "session"           : Service::getSession(),
            "cookie"            : Service::getCookie(),
            "crypt"             : Service::getCrypt(),
            "redis"             : Service::getRedis(),
            "mysql"             : Service::getMySQL(),
            "view"              : Service::getView()
            //"mongo"             : Service::getMongoDB(),
            //"collectionManager" : Service::getCollectionManager()
        ];
    }

    /**
     * Get loader
     * Retrieve application loader
     *
     * @return App\Loader
     */
    public inline function getLoader()
    {
        return this->loader;
    }

    /**
     * Get application
     *
     * @return Phalcon\Mvc\Application
     */
    public inline function getApplication()
    {
        return this->application;
    }

    /**
     * Set root
     * Set current root path where application will be runned
     *
     * @param string root
     * @return App\App
     */
    public inline function setRoot(root)
    {
        this->config->setRoot(root);
        return this;
    }

    /**
     * Get rooot
     *
     * @return string
     */
    public inline function getRoot()
    {
        return this->config->getRoot();
    }

    /**
     * Run application
     *
     */
    public inline function run()
    {
        let this->loader = new Loader();
        this->loader->registerNamespaces();

        let this->application = new Application(this->service);
        echo this->application->handle()->getContent();
    }

    public inline function test()
    {
        var func;

        let func = function(str1, str2) {
            echo str1." ". str2;
        };

        call_user_func_array(func, ["Hello", "World"]);
    }

}