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
     * Set service
     * Assign all services to application
     *
     * @param App\Service service
     * @return App\App
     */
    public inline function setService(service)
    {
        let this->service = service;
        return this;
    }

    /**
     * Get service
     * Retrieve current services of application
     *
     * @return App\Service
     */
    public inline function getService()
    {
        return this->service;
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
        var app, loader, service = "";

        let loader = new Loader();
        loader->registerNamespaces();

        let app = new Application(service);
        echo app->handle()->getContent();
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