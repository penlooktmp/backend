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
class Topic extends Collection
{
    public data;
    public type;
    public time;
    public comment;
    public like;

	public inline function initialize()
	{
		parent::initialize();
		let this->time = time();
	}

	public inline function getSource()
    {
        return "topic";
    }

    public inline static function getAllTopic()
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
        let this->comment = [];
        let this->like = [];
        let this->type = type;
        let this->data = data;
        this->save();
    }

}

