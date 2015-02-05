/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *      Nam Vo      <namvh@penlook.com>
 *      Loi Nguyen  <loint@penlook.com>
 *      Tin Nguyen  <tinntt@penlook.com>
 *
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
