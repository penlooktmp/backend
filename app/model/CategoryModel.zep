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
 * Category Model
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
class CategoryModel extends Model
{
    /**
     * category of skill
     *
     * @var category
     */
    private category;
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public inline function __construct(var category)
    {
        parent::__construct();
        let this->category = category;
    }

    /**
     * Get All Skill
     * This is get all skill function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array object
     */
    public inline function getAllSkill()
    {
        return Skill::find([
            "category = '".this->category."'"
        ])->toArray();
    }

    /**
     * Get Category Name
     * This is get category name function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public inline function getCategoryName()
    {
        return Skill::findFirst([
            "category = '".this->category."'",
            "columns" : "categoryname"
        ]);
    }
}