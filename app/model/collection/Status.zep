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
 * Flow Collection 
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

