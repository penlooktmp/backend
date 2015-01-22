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
namespace App\Model; 

use App\Model\Collection\Like;
use App\Model;

/**  
 * Comment Model
 *     
 * @category   Penlook Application  
 * @package    App\Model  
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial 
 * @version    1.0  
 * @link       http://penlook.com
 * @since      Class available since Release 1.0 
 */ 
class LikeModel extends Model
{	
    /**
     * SkillTable instance
     * 
     * @var skill
     */
    private like;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string id
     */
    public inline function __construct(id = null, status_id = null)
    {
        parent::__construct();
        if  (!is_string(id) || ((strlen(id) < 20) && !is_null(id))) {
            return;
        }

        if (!is_null(id))
        {
            let this->like = Like::findById(id);
        }
        else
        {
            if (!is_null(status_id))
            { 
                let this->like = Like::find([[
                    "data.parent_id" : status_id
                    ]
                ]);
            }
            else
            {
                let this->like = Like::find();
            }
        }
    }

    /**
     * Get Data from table object
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getLike()
    {
        return this->like;
    }

    public inline function getLikeByStatusId(var id)
    {
        return Like::find([
            "status_id = '".id."'"
            ]);
    }
    /**
     * Is Valid
     * This is check valid id function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public inline function isValid()
    {
        return is_object(this->like->{"_id"}) ? true : false;
    }

}