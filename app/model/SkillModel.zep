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

use App\Model\Table\Skill;
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
class SkillModel extends Model
{	
    /**
     * SkillTable instance
     * 
     * @var skill
     */
    private skill;
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public inline function __construct(id) 
    {
        parent::__construct();

        if (is_numeric(id)) {
            let this->skill = Skill::findFirst([
                "id = '".id."'"
            ]);
        } else {
            let this->skill = Skill::findFirst([
                "alias = '".id."'"
            ]);
        }

    }

    /**
     * Get Data from table object
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getData()
    {
        return this->skill;
    }
    /**
     * Get friend
     * This is get friend function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return array object
     */
    public inline function getRelativeSkill()
    {
        return Skill::find([
            "category = '".this->skill->category."'",
            "columns" : "alias"
        ])->toArray();

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
        return is_object(this->skill) ? true : false;
    }
}