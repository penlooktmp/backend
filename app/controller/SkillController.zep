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

namespace App\Controller;

use Phalcon\Mvc\View;
use App\Controller;
use App\Model\AppModel;
use App\Model\SkillModel;

/**
 * App Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class SkillController extends Controller
{
    public function indexAction() {
        //this->category();
        // return this->forward([
        //     "action" : "description"
        // ]);
    }

    public inline function categoryAction() {
        var skills;

        let skills = [
            "PHP", "Android", "Hack System", "C#", "HTML", "CSS"
        ];

        this->out([
            "name": "Software",
            "skills": skills
        ]);

        /*this->res("css", [
            "lib/bootstrap/bootstrap",
            "lib/config",
            "lib/core",
            "modules/index_header",
            "modules/skill_category",
            "modules/skill_category_tag",
            "modules/app_search",
            "modules/app_footer"
        ], true, true);*/

        //this->pick("skill/category");
    }

    public inline function descriptionAction() {
        this->out([
            "login": true
        ]);

        /*this->res("css", [
            "lib/bootstrap/bootstrap",
            "lib/config",
            "lib/core",
            "modules/index_header",
            "modules/skill_item_description",
            "modules/skill_item_reference",
            "modules/skill_item_reference_content",
            "modules/skill_item_side_bar",
            "modules/app_search",
            "modules/app_footer"
        ], true, true);*/

        this->out("category_name", "abc");
        //this->pick("skill/skill_description");
    }
}
