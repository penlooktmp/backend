/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Loi Nguyen <loint@penlook.com>
 *
 */
namespace App;

use Phalcon\Config as Phalcon_Config;

/**
 * App Configuration
 *
 * @category   Penlook Application
 * @package    App\Config
 * @author     Loi Nguyen <loint@penlook.com>
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
        return [
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
                ],
                "neo4j" : [
                    "host" : "127.0.0.1",
                    "port" : 123
                ]
            ]
        ];
    }
}