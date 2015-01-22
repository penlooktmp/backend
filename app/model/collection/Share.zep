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
 * Share Collection 
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
class Share extends Collection 
{
	public user_id;

    public status_id;

	public name;

	public time;

    public data;

	public function getSource()
    {
        return "share";
    }

    public static function getAllShares()
    {
    	return self::find();
    }

    public static function getShareByStatusId(var status_id)
    {
    	return self::find([
    		["status_id" 	 : status_id],
    		"sort" 		     : ["time" : 1]
			]);
    }

    public function saveLike(var user_id, var status_id, var name, var data)
    {
    	let this->time 		= date("Y/m/d H:i:s");
    	let this->user_id 	= user_id;
    	let this->status_id = status_id;
    	let this->name 		= name;
        let this->data      = data; 
    	this->save();
    }

}
