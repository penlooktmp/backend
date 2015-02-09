/*
 +--------------------------------------------------------------------------+
 | Penlook Project                                                          |
 +--------------------------------------------------------------------------+
 | Copyright (c) 2015 Penlook Development Team                              |
 +--------------------------------------------------------------------------+
 |                                                                          |
 | This program is free software: you can redistribute it and/or modify     |
 | it under the terms of the GNU Affero General Public License as           |
 | published by the Free Software Foundation, either version 3 of the       |
 | License, or (at your option) any later version.                          |
 |                                                                          |
 | This program is distributed in the hope that it will be useful, but      |
 | WITHOUT ANY WARRANTY; without even the implied warranty of               |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
 | GNU Affero General Public License for more details.                      |
 |                                                                          |
 | You should have received a copy of the GNU Affero General Public License |
 | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
 |                                                                          |
 +--------------------------------------------------------------------------+
 |   Authors: Loi Nguyen  <loint@penlook.com>                               |
 |            Tin Nguyen  <tinntt@penlook.com>                              |
 |            Nam Vo      <namvh@penlook.com>                               |
 +--------------------------------------------------------------------------+
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