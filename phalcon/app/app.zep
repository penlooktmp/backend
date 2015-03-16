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

use Phalcon\App\Flow;
use Phalcon\App\Config;
use Phalcon\App\Service;
use Phalcon\App\Loader;
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
     * Session
     *
     * @var Phalcon\Session\Adapter\Files
     */
    private session;

    /**
     * Service
     *
     * @var Phalcon\Mvc\Application
     */
    private application;

    /**
     * Logger
     *
     * @var App\Log
     */
    private logger;

    /**
     * Template directory
     *
     * @var string
     */
    private template;

    /**
     * Web page
     *
     * @var string
     */
    private html;

    /**
     * Temporary property
     */
    public debug;

    /**
     * Mode
     *
     * @var int
     */
    public static mode;

    /**
     * Initialize application
     *
     * @return App\App
     */
    public function initialize()
    {
        switch self::mode {
            case self::DEBUG:
                    this->setupDebug();
                break;
            case self::RELEASE:
                    this->setupRelease();
                break;
            case self::MAINTAIN:
                    this->setupMaintain();
                break;
            default:
                break;
        }

        let this->config  = Config ::getInstance(this);
        let this->service = Service::getInstance();
        let this->session = Service::getSession();

        return this;
    }

    /**
     * Setup for development mode
     *
     */
    public function setupDebug()
    {
        Flow::start("index.php");
        error_reporting(E_ALL);
        ini_set("display_errors", true);
    }

    /**
     * Setup for production mode
     *
     */
    public function setupRelease()
    {
        error_reporting(0);
        ini_set("display_errors", false);
    }

    /**
     * Setup for maintain mode
     *
     */
    public function setupMaintain()
    {
        this->session->set("mode", App::MAINTAIN);
        // TODO
    }

    /**
     * Set logger
     *
     * @param {App\Log} logger
     */
    public function setLogger(logger)
    {
        let this->logger = logger;
        return this;
    }

    /**
     * Get logger
     *
     * @return {App\Log}
     */
    public function getLogger()
    {
        return this->logger;
    }

    /**
     * Set mode
     * Switch mode for application
     *
     * @param int mode
     * @return {App\App}
     */
    public function setMode(mode)
    {
        let self::mode = mode;

        // Initialize application by mode
        this->initialize();

        return this;
    }

    /**
     * Change current mode
     *
     */
    public static function changeMode(mode)
    {
        let self::mode = mode;
    }

    /**
     * Get mode
     * Retrieve current mode of application
     *
     * @return int
     */
    public static function getMode()
    {
        return self::mode;
    }

    /**
     * Check debug mode | Debug
     *
     * @param  {int} variable       Debug mode
     * @return {boolean | string}
     */
    public static function debug(variable = false)
    {
        if ! variable {
            return self::mode === self::DEBUG ? true : false;
        }

        echo "<pre>";
        print_r(variable);
        echo "</pre>";
    }

    /**
     * Get service
     * Retrieve current service container
     *
     * @return Phalcon\DI\FactoryDefault
     */
    public function getService()
    {
        return this->service;
    }

    /**
     * Set multiple services
     *
     * @param function callback
     * @return App\App
     */
    public function setServices(callback)
    {
        call_user_func_array(callback, [ this->getListServices() ]);
        return this;
    }

    /**
     * Set single service
     *
     * @return App\App
     */
    public function setService(name, closure)
    {
        this->getService()->getService()->set(name, closure);
        return this;
    }

    /**
     * Get list services
     * Retrieve all service are already registered
     *
     * @return array
     */
    public function getListServices()
    {
        Flow::pick("Get list services");

        return [
            "url"               : Service::getUrl(),
            "config"            : Service::getConfig(),
            "router"            : Service::getRouter(),
            "cookie"            : Service::getCookie(),
            "redis"             : Service::getRedis(),
            "view"              : Service::getView(),
            "session"           : Service::getSession(),
            "mysql"             : Service::getMySQL(),
            "mongo"             : Service::getMongoDB(),
            "collectionManager" : Service::getCollectionManager()
        ];
    }

    /**
     * Set loader
     *
     * @param {App\Loader} loader
     * @return App\App
     */
    public function setLoader(loader)
    {
        let this->loader = loader;
        return this;
    }

    /**
     * Get loader
     * Retrieve application loader
     *
     * @return App\Loader
     */
    public function getLoader()
    {
        return this->loader;
    }

    /**
     * Set application instance
     *
     * @param Phalcon\Mvc\Application app
     * @return App\App
     */
    public function setApplication(app)
    {
        let this->application = app;
        return this;
    }

    /**
     * Get application instance
     *
     * @return Phalcon\Mvc\Application
     */
    public function getApplication()
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
    public function setRoot(root)
    {
        this->config->setRoot(root);

        // Initialize configuration
        this->config->initialize();

        return this;
    }

    /**
     * Get root
     *
     * @return string
     */
    public function getRoot()
    {
        return this->config->getRoot();
    }

    /**
     * Set template directory
     *
     * @param string template
     * @return {App\App}
     */
    public function setTemplate(template)
    {
        let this->template = realpath(template);
        return this;
    }

    /**
     * Get template directory
     *
     * @return string
     */
    public function getTemplate()
    {
        return this->template;
    }

    /**
     * Start application
     *
     * @return {App\App}
     */
    public function start()
    {
        Flow::pick("Setup loader and application");

        this->setLoader(new Loader())
            ->setApplication(new Application(this->service->getService()));

        Flow::pick("Start handle router");

        let this->html = this->getApplication()->handle()->getContent();
        return this;
    }

    /**
     * Get HTML Page
     *
     * @return string
     */
    public function html()
    {
        return this->html;
    }

    /**
     * Application flow
     *
     * @return string html
     */
    public function flow()
    {
        return Flow::graph();
    }

}