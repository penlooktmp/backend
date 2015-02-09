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

    const DEBUG    = 0;
    const RELEASE  = 1;
    const MAINTAIN = 2;

    private config;
    private service;

    public session;
    public debug;
    public mode;

    public inline function __construct()
    {
        let this->config = Config::getInstance();
    }

    public inline function setMode(mode)
    {
        let this->mode = mode;
        return this;
    }

    public inline function getMode()
    {
        return this->mode;
    }

    public inline function setService(service)
    {
        let this->service = service;
        return this;
    }

    public inline function getService()
    {
        return this->service;
    }

    public inline function setRoot(root)
    {
        this->config->setRoot(root);
        return this;
    }

    public inline function getRoot()
    {
        return this->config->getRoot();
    }

    public inline function run()
    {
        var app, loader, service = "";

        let loader = new Loader();
        loader->registerNamespaces();

        let app = new Application(service);
        echo app->handle()->getContent();
    }

}