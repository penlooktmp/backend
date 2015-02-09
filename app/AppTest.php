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

/**
 * App Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class AppTest extends Test
{

    private $app;

    public function __construct()
    {
        $this->app = App::getInstance();
    }

    public function testGetInstance()
    {
        $input = $this->app;
        $expect = $this->app;
        $output = App::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testStart()
    {
        //Not yet handled
    }

    public function testEnd()
    {
        //Not yet handled
    }

    public function testSetMode()
    {
        $input = false;
        $expect = NULL;
        $output = $this->app->setMode($input);
        $this->assertEquals($output, $expect);
    }

    public function testGet()
    {
        $input = "viet";
        $expect = NULL;
        $output = $this->app->setMode($input);
        $this->assertEquals($output, $expect);
    }

    public function testSet()
    {
        $input = "viet";
        $expect = NULL;
        $output = $this->app->setMode($input);
        $this->assertEquals($output, $expect);
    }
}
