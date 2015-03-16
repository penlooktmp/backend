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

namespace Phalcon\Driver\Redis;

use Phalcon\Driver\Redis\Exception;

/**
 * Redis Driver
 *
 * @category   Penlook Application
 * @package    Driver\Redis
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Redis {

	/**
	 * Redis connection
	 */
	private connection;

	/**
	 * Establish new redis connection
	 *
	 * @param  {string} host = "127.0.0.1" Ip address
	 * @param  {int}    port = 6378        Port number
	 * @return {resource} Redis resource
	 */
	public function connect(host = "127.0.0.1", port = 6379)
	{
		if host == "localhost" {
			let host = "127.0.0.1";
		}

		var ex;

		try {
			let this->connection = redis("connect", host, port);
		} catch Exception, ex {
			throw ex;
		}
	}

	/**
	 * Get redis connection
	 *
	 * @return {resource} Redis resource
	 */
	public function getConnection()
	{
		return this->connection;
	}

	/**
	 * Set key and value
	 *
	 * @param {string} key
	 * @param {string} value
	 * @return {string} redis response
	 */
	public function set(key, value)
	{
		var connection, reply;
		let connection = this->connection;
		let key = (string) key;
		let value = (string) value;
		let reply = redis("set", connection, key, value);
		return reply;
	}

	/**
	 * Set key and value
	 *
	 * @param {string} key
	 * @return {string} value
	 */
	public function get(key)
	{
		var connection, reply;
		let connection = this->connection;
		let key = (string) key;
		let reply = redis("get", connection, key);
		return reply;
	}
}