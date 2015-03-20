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

namespace Phalcon\App;

use Phalcon\App\App;

/**
 * Application Flow
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Flow
{

	/**
	 * Application flow - a stop watch for application
	 *
	 */
	public static flow;

	/**
	 * Start flow
	 *
	 * @param string message
	 */
	public static function start(message = "")
	{
		if ! App::debug() {
			let self::flow = false;
			return;
		}

		let self::flow = [];
		Flow::push(message);
	}

	/**
	 * Pick a message to queue
	 *
	 * @param string message
	 */
	public static function pick(message = "")
	{
		if ! App::debug() {
			return;
		}

		Flow::push(message);
	}

	/**
	 * Push current state to queue
	 *
	 * @param string message
	 */
	public static function push(message)
	{
		var time, memory, class_name, method_name;
		let time   = (float) microtime(true);
		let memory = (double) (memory_get_peak_usage(true));

		var callers;
		let callers = debug_backtrace();
		let class_name  = callers[2]["class"];
		let method_name = callers[2]["function"];

		let self::flow[] = [
			"class_name"  : class_name,
			"method_name" : method_name,
			"time"        : time,
			"memory"      : memory,
			"message"     : message
		];
	}

	/**
	 * Retrieve all state in flow
	 *
	 * @return array Array of states
	 */
	public static function getFlow()
	{
		return self::flow;
	}

	public static function graph()
	{
		/*if ! App::debug() {
			return;
		}

		var view, flow;
		let flow = clone self::getFlow();
		let view = Service::getView();
		view->start();

		view->getRender("performance", "graph",[]);

		return view;
		*/
		//view->finish();

 		//return view->getContent();
	}
}