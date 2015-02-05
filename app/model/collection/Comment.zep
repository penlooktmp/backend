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
class Comment extends Collection
{
    public status_id;

	public data;

	public time;


	public function getSource()
    {
        return "comment";
    }

    public static function getAllComments()
    {
    	return self::find();
    }

    public static function getCommentByStatusId(var status_id)
    {
    	return self::find([
    		["status_id" 	 : status_id],
    		"sort" 		     : ["time" : 1]
			]);
    }

    public function post(var data)
    {
        let this->data = data;
        this->save();
    }

}
