<?php
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
 *     Viet Nguyen      <vietna@penlook.com>
 */

namespace App;

/**
 * Service Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class ServiceTest extends Test
{
    private $service;

    public function __construct()
    {
        $this->service = Service::getInstance();
        Config::getInstance()
              ->setRoot(__DIR__)
              ->initialize();
    }

    public function testGetInstance()
    {
        $input = $this->service;
        $expect = $this->service;
        $output = Service::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testGetView()
    {
        $view = $this->service->getView();
        $this->assertInstanceOf("Phalcon\Mvc\View", $view);
    }

    public function testGetMysql()
    {
        $mysql = $this->service->getMySQL();
        $this->assertInstanceOf("Phalcon\Db\Adapter\Pdo\Mysql", $mysql);
    }

    public function testGetMongo()
    {
        //$mongo = $this->service->getMongoDB();
        //$this->assertInstanceOf("MongoClient", $mongo);
        //$mongo->close();
    }
}
