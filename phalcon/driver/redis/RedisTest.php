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

namespace Phalcon;

use Phalcon\Driver\Redis\Redis;

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
class RedisTest extends Test
{

	public function testRedisConnectionWrongPort()
	{
		$redis = new Redis();
		$flag = false;

		try {
			$redis->connect("localhost", 12345);
		} catch (\Exception $e) {
			$this->assertEquals(10001, $e->getCode());
			$this->assertEquals(false, $redis->getConnection());
			$flag = true;
		}

		// Must throw exception with wrong port number
		$this->assertEquals(true, $flag);
	}

	public function testRedisConnectionDefaultPort()
	{
		$redis = new Redis();
		$flag = false;

		try {
			$redis->connect();
		} catch (\Exception $e) {
			$flag = true;
		}

		$this->assertNotEquals(false, $redis->getConnection());
		$this->assertEquals(true, is_resource($redis->getConnection()));

		// Not throw exception with default port number
		$this->assertEquals(false, $flag);
	}

	public function testRedisGetNotExistKey()
	{
		$redis = new Redis();
		$redis->connect();
		$this->assertEquals(true, is_resource($redis->getConnection()));
		$key = "TEST" . rand(1000, 1000000);
		$this->assertEquals(false, $redis->get($key));
	}

	public function testRedisSetGet()
	{
		$redis = new Redis();
		$redis->connect();
		$this->assertEquals(true, is_resource($redis->getConnection()));
		$key = "TEST" . rand(1000, 1000000);
		$redis->set($key, "ABCDZZZ");
		$this->assertEquals("ABCDZZZ", $redis->get($key));
	}

}