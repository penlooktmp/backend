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
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
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
     * Config Instance
     *
     * @var App\Config
     */
	private static static_config;

    /**
     * Path
     *
     * @var App\Path
     */
    public path;

    /**
     * Constructor
     *
     */
    private function __construct()
	{
		var path, raw_config, raw_path, config, storage;
		let path = Path::getInstance();

		// Resolve storage file location
        let this->path = path;
        let config = this->config();

        let raw_config = config["storage"];
        let storage = this->configurePath(raw_config, path->root);

        let raw_path = config["path"];
        let this->path = raw_path;

        var configs;

        let configs = [
            "app" : config["app"],
            "path" : config["path"],
            "storage" : storage
        ];

		// Convert array to object
		let this->config = new Phalcon_Config(configs);
	}

    /**
     * Get an instance
     *
     * @return App\Config
     */
	public inline static function getInstance()
    {
        if (!self::static_config) {
            let self::static_config = new Config();
        }

        return self::static_config;
    }

    /**
     * Get configuration
     *
     * @return Phalcon\Config
     */
    public inline function getConfig()
    {
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

    public inline function config()
    {

        return
        [
            "app" : [
                "language" : "en_US"
                ],
                "path": [
                    "site" : [
                        "root"   : "",
                        "static" : ""
                    ]
                ],
                "storage": [
                    "app" : [
                        "controller" : "app/controller",
                        "model"      : "app/model",
                        "view"       : "public/view",
                        "cache"      : "tmp/cache",
                        "storage"    : "tmp/storage"
                    ],
                    "cloud" : [
                        "key" : "value"
                    ],
                    "mysql" : [
                        "host" : "localhost",
                        "port" : 3306,
                        "username" : "root",
                        "password" : "",
                        "dbname" : "penlook"
                    ],
                    "mongo" : [
                        "host" : "127.0.0.1",
                        "port" : 27017,
                        "username" : "admin",
                        "password" : "",
                        "dbname" : "penlook",
                        "charset" : "utf8"
                    ],
                    "redis" : [
                        "host" : "127.0.0.1",
                        "port" : 6379
                    ]
                ]
        ];

    }
}
