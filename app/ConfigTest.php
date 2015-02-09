<?php
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
 |            Viet Nguyen <vietna@penlook.com>                              |
 +--------------------------------------------------------------------------+
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
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class ConfigTest extends Test
{
    protected $config;

    public function __construct()
    {
        $this->config = Config::getInstance();
    }

    public function testGetInstance()
    {
        $input = $this->config;
        $expect = $this->config;
        $output = Config::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testGetConfig()
    {
        // Unknown
    }

    public function testConfigurePath()
    {
        // Unknown
    }

    public function testConfig()
    {
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
