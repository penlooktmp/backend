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
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

namespace App;

/**
 * Flow Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class FlowTest extends Test
{

    // Spent memory to test monitor
    public function loop($num)
    {
        $datai = array ();
        for ($i = 1; $i <= $num; $i++) {
            $dataj = array();
            for ($j = 1; $j <= 100; $j++) {
                $dataj[] = array(
                    "test1" => $i,
                    "test2" => $j,
                    "test3" => $i * $j
                );
            }
            $datai[] = $dataj;
        }
    }

    /**
     * Test Application Flow in debug mode
     */
    public function testFlowDebug()
    {
        App::changeMode(App::DEBUG);
        Flow::start("LOOP 0");

        for ($f = 1; $f <= 5; $f++) {
            $this->loop($f * 100);
            Flow::pick('LOOP '. $f * 100);
        }

        $this->assertEquals(6, count(Flow::getFlow()));
    }

    /**
     * Test Application Flow in release mode
     */
    public function testFlowRelease()
    {
        App::changeMode(App::RELEASE);
        Flow::start("LOOP 0");

        for ($f = 1; $f <= 5; $f++) {
            $this->loop($f * 100);
            Flow::pick('LOOP '. $f * 100);
        }

        $this->assertNull(Flow::getFlow());
    }

}
