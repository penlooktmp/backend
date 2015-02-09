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
 * Flow Collection
 *
 * @category   Penlook Application
 * @package    App\Collection
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Status extends Collection
{
    public data;
    public type;
    public time;

	public inline function initialize()
	{
		parent::initialize();
		let this->time = time();
	}

	public inline function getSource()
    {
        return "status";
    }

    public inline static function getAllStatus()
    {
    	return self::find([
    	    "sort" : [
    	        "time" : -1
    	    ],
    	    "limit" : 20
  	    ]);
    }

    public inline function post(type, data)
    {
        let this->time = date("Y/m/d H:i:s");
        let this->type = type;
        let this->data = data;
        this->save();
    }

}

    /*
    public inline static function getStatusByUserId(var user_id, var status_num)
    {
    	return self::find([
    		["user_id" 	: user_id],
    		"sort" 		: ["time" : 1],
    		"limit" 	: status_num
			]);
    }

    public inline function uploadStatus(var text)
    {
    	var data;
    	let data = ["text" : text];
    	let this->time 		= date("Y/m/d H:i:s");
    	let this->type 		= "update_status";
    	let this->data 		= data;
    	this->save();
    }

    public inline function uploadPhoto(var text, var image = [])
    {
    	var data;
    	let data = ["text" : text,
    				"img"  : image];
    	let this->time 		= date("Y/m/d H:i:s");
    	let this->type 		= "upload_photo";
    	let this->data 		= data;
    	this->save();
    }

    public inline function updateHeadline(var text, var new_position, var new_location, var link, var image = [])
    {
    	var data;
    	let data = ["text" 			: text,
    				"new_position"	: new_position,
    				"new_location"	: new_location,
    				"link" 			: link,
    				"img"  			: image];
    	let this->time 		= date("Y/m/d H:i:s");
    	let this->type 		= "update_headline";
    	let this->data 		= data;
    	this->save();
    }

    public inline function updateAvatar(var image)
    {
    	var data;
    	let data = ["img"	: image];
    	let this->time 		= date("Y/m/d H:i:s");
    	let this->type 		= "change_avatar";
    	let this->data 		= data;
    	this->save();
    }*/

