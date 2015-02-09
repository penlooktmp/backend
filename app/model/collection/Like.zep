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

namespace App\Model\Collection;

use App\Collection;

/**
 * Comment Collection
 *
 * @category   Penlook Application
 * @package    App\Collection
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Like extends Collection
{
	public data;

	public time;

	public function getSource()
    {
        return "like";
    }

    public static function getAllLikes()
    {
    	return self::find();
    }

    public static function getLikeByStatusId(var status_id)
    {
    	return self::find([
    		["status_id" 	 : status_id],
    		"sort" 		     : ["time" : 1]
			]);
    }

    public function post(var data)
    {
    	let this->time = date("Y/m/d H:i:s");
    	let this->data = data;
    	this->save();
    }

    public static function  saveUnLike(var status_id)
    {
        var user_id = "11", like_status; //hard code, can get by Auth class
        let like_status = self::findFirst([[
                "user_id" : user_id,
                "status_id" : status_id
        ]]);
        like_status->delete();
    }

}
