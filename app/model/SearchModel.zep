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
use App\Model\Table\Org;
use App\Model\Table\User;
use App\Model;

/**  
 * Search Model
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
class SearchModel extends Model
{	
    /**
     * Keyword search
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var $keyword
     */
    public keyword;
    public index;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $keyword
     */
    public inline function __construct(var keyword = null)
    {
        parent::__construct();
        let this->keyword = keyword;
        let this->index = 0;
    }

    /**
     * Change Keyword
     * This is change keyword function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $keyword
     */
    public inline function changeKeyword(var keyword)
    {
        let this->keyword = keyword;
    }

    public inline function scan(result)
    {
        var item, new_result;
        let new_result = [];

        for item in result {
            let this->index  = this->index + 1;
            let item["index"]   = (int) this->index;
            let new_result[] = item;
        }

        return new_result;
    }

    /**
     * Get Suggest User
     * This is get suggest user function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param Array Object
     */
    public inline function getSuggestUser()
    {
        var user;
        let user = User::find([
            "name like '%".this->keyword."%' OR headline like '%".this->keyword."%'",
            "columns" : "id, name, headline as info, avatar as image"
        ])->toArray();

        return this->scan(user);
    }

    /**
     * Get Suggest Skill
     * This is get suggest skill function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param Array Object
     */
    public inline function getSuggestSkill()
    {
        var skill;
        let skill = Skill::find([
            "skillname like '%".this->keyword."%' OR categoryname like '%".this->keyword."%'",
            "columns" : "id, skillname as name, categoryname as info, image as image"
        ])->toArray();

        return this->scan(skill);
    }  

    /**
     * Get Suggest Organization
     * This is get suggest organization function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param Array Object
     */
    public inline function getSuggestOrganization()
    {
        var org;
        let org = Org::find([
            "name like '%".this->keyword."%' OR address like '%".this->keyword."%'",
            "columns" : "id, name as name, address as info, image as image"
        ])->toArray();

        return this->scan(org);
    }
}