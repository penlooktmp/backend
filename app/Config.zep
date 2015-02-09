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

use Phalcon\Config as Phalcon_Config;

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
class Config
{

    /**
     * Configuration
     *
     * @var Phalcon\Config
     */
    public config;

    /**
     * Application root
     *
     * @var string
     */
    public root;

    /**
     * Config Instance
     *
     * @var App\Config
     */
	private static static_config;

    /**
     * Config constructor
     *
     */
    private inline function __construct()
    {
        // Override constructor
    }

    /**
     * Get an instance
     *
     * @return App\Config
     */
	public inline static function getInstance()
    {

        if ! self::static_config {
            let self::static_config = new Config();
        }

        return self::static_config;
    }

    /**
     * Constructor
     *
     */
    public function initialize()
    {
        var config;

        let config = this->getRawConfig();

        /*let raw_config = config["storage"];
        let storage = this->configurePath(raw_config, path->root);

        let raw_path = config["path"];
        let this->path = raw_path;
        */

        let this->config =  new Phalcon_Config([
                                "app" : config["structure"]
                            ]);

        return this;
    }


    /**
     * Get configuration
     *
     * @return Phalcon\Config
     */
    public inline function getConfig()
    {
        if ! this->root {
            die("Application root was not defined !");
        }

    	return this->config;
    }

    /**
     * Configure application path
     *
     * @return array
     */
    public inline function configurePath(raw_config, path_app)
    {
        var key, value, tmp;
        let tmp = [];

    	for key, value in raw_config["app"] {
            let tmp[key] = path_app . "/" . value ."/";
    	}

        let raw_config["app"] = tmp;
    	return raw_config;
    }

    /**
     * Get config by key
     *
     * @param  string name Config file name
     * @param  string config_name Config services in file name
     * @return string
     */
    public inline function get(name, config_name)
    {
        var redis, value = [];
        let redis = Service::getInstance()->getRedis();
        let value = json_decode(redis->get(name), true);
        return value[config_name];
    }

    /**
     * Configuration
     *
     * @return array
     */
    public inline function getRawConfig()
    {
        return [
            "language"  : "en_US",
            "structure" : this->get("phalcon.yml", "structure"),
            "database"  : [
                "mysql" : this->get("mysql.yml",  "mysql"),
                "mongo" : this->get("mongo.yml",  "mongo")
            ]
        ];
    }

    /**
     * Set application root
     *
     * @param string root application root
     */
    public inline function setRoot(root)
    {
        var path;
        let path = realpath(root);

        if ! path {
            die("Application Path does not exist !");
        }

        let this->root = path;
        return this;
    }

    /**
     * Get application root
     *
     * @return string
     */
    public inline function getRoot()
    {
        return this->root;
    }

}
