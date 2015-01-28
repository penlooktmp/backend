<?php
/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Viet Nguyen <vietna@penlook.com>
 *
 */
namespace App;

use App\Config;

/**
 * Config Test
 *
 * @category   Penlook Application
 * @package    App
 * @author     Viet Nguyen <vietna@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class ConfigTest extends Test
{
    protected $config;

    public function __construct() {
        $this->config = Config::getInstance();
    }

    public function testGetInstance(){
        $input = $this->config;
        $expect = $this->config;
        $output = Config::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testGetConfig(){
        // Unknown
    }

    public function testConfigurePath(){
        // Unknown
    }

    public function testConfig(){
        // $input = $this->config;
        // $expect = [
        //     "app" : [
        //         "language" : "en_US"
        //     ],
        //     "path": [
        //         "site" : [
        //             "root"   : "",
        //             "static" : ""
        //         ]
        //     ],
        //     "storage": [
        //         "app" : [
        //             "controller" : "app/controller",
        //             "model"      : "app/model",
        //             "view"       : "public/view",
        //             "cache"      : "tmp/cache",
        //             "storage"    : "tmp/storage"
        //         ],
        //         "cloud" : [
        //             "key" : "value"
        //         ],
        //         "mysql" : [
        //             "host" : "localhost",
        //             "port" : 3306,
        //             "username" : "root",
        //             "password" : "",
        //             "dbname" : "penlook"
        //         ],
        //         "mongo" : [
        //             "host" : "127.0.0.1",
        //             "port" : 27017,
        //             "username" : "admin",
        //             "password" : "",
        //             "dbname" : "penlook",
        //             "charset" : "utf8"
        //         ],
        //         "redis" : [
        //             "host" : "127.0.0.1",
        //             "port" : 6379
        //         ],
        //         "neo4j" : [
        //             "host" : "127.0.0.1",
        //             "port" : 123
        //         ]
        //     ]
        // ];
        // $output = $this->config->config();
        // $this->assertEquals($output, $expect);
    }
}
