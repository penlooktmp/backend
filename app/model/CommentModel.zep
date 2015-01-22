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

use App\Model\Collection\Topic;
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
class CommentModel extends Model
{
    /**
     * SkillTable instance
     *
     * @var skill
     */
    private comment;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string id
     */
    public inline function __construct(status_id, id = null)
    {
        parent::__construct();

        if  (!is_string(status_id) || ((strlen(status_id) < 20) && !is_null(status_id)) || is_null(status_id)) {
            return;
        }

        if (is_null(id))
        {
            let this->comment = Topic::findById(status_id);
        }
        else
        {
            let this->comment = Topic::findById(status_id)->{"data"}["comment"][id];
        }
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getComment()
    {
        return this->comment;
    }

    public inline function getCommentByStatusId(var id)
    {
        return Topic::find([
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
        return is_object(this->comment->{"_id"}) ? true : false;
    }

}