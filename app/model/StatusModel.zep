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

use App\Model\Collection\Status;
use App\Model;

/**
 * Skill Model
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
class StatusModel extends Model
{
    /**
     * SkillTable instance
     *
     * @var skill
     */
    private status;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string id
     */
    public inline function __construct(id = null, des_id = null)
    {
        parent::__construct();
        if  (!is_string(id) || ((strlen(id) < 20) && !is_null(id))) {
            return;
        }

        if (!is_null(id))
        {
            let this->status = Status::findById(id);

        }
        else{
            if (des_id != "")
            {
                let this->status = Status::find([[
                    "data.des_id" : des_id
                    ]
                ]);
            }
            else
            {
                let this->status = Status::find();
            }
        }
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getStatus()
    {
        return this->status;
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
        return is_object(this->status->{"_id"}) ? true : false;
    }

}