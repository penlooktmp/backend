/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Tin Nguyen <tinntt@penlook.com>
 *
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
