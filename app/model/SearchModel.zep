/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
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
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
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
    public function __construct(var keyword = null)
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
    public function changeKeyword(var keyword)
    {
        let this->keyword = keyword;
    }

    public function scan(result)
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
    public function getSuggestUser()
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
    public function getSuggestSkill()
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
    public function getSuggestOrganization()
    {
        var org;
        let org = Org::find([
            "name like '%".this->keyword."%' OR address like '%".this->keyword."%'",
            "columns" : "id, name as name, address as info, image as image"
        ])->toArray();

        return this->scan(org);
    }
}