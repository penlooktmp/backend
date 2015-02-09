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

use App\Model\Table\User;
use App\Model\Table\Avatar;
use App\Model\Table\UserWidget;
use App\Model;

/**
 * Ajax Model
 *
 * @category   Penlook Application
 *
 * @package    App\Model
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class AjaxModel extends Model
{
    /**
     * AjaxModel instance
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var AjaxModel
     */
    private static static_ajax;

    /**
     * Get Instance
     * This is get instance function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return AjaxModel
     */
    public static function getInstance()
    {
        if (!self::static_ajax) {
            let self::static_ajax = new AjaxModel();
        }

        return self::static_ajax;
    }

    /**
     * Update Avatar
     * This is update avatar function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param datatype $paramname description
     */

    public function updateAvatar(var avatar, var user_id)
    {
        var avatar_model;

        let avatar_model = Avatar::findFirst([
            "user_id = '".user_id."'"
        ]);

        avatar_model->save([
            "x" : avatar->x,
            "y" : avatar->y,
            "s" : avatar->s
        ]);
    }

    /**
     * Is exist email
     * This is check existed email function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $email
     * @return bool
     */
    public function isExistedEmail(string email)
    {
        var user;
        let user = false;
        let user = User::findFirst([
            "email = '".email."'"
        ]);

        return is_object(user);
    }

    /**
     * Save step
     * This is save data for user table function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param object $data
     */
    public function saveSteps(var data)
    {
        var id, user, key, value;

        for key, value in data
        {
            this->session(key, value);
        }

        let id = this->session("user_id");

        let user = User::find(["id = '".id."'"]);

        user->save([
            "step" : this->session("step")
        ]);
    }

    /**
     * Save widget content
     * This is save widget content function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $widget
     * @param string $keys
     * @param string $values
     */
    public function saveWidgetContent(string widget, string keys, string values)
    {
        var user_widget;

        let user_widget = new UserWidget();

        user_widget->save([
            "user"          : this->session("user_id"),
            "widget"        : widget,
            "widget_keys"   : keys,
            "widget_values" : values
        ]);
    }

    /**
     * load widget content
     * This is load widget content function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return object
     */
    public function loadWidgetContent()
    {
        var user, content;
        let user = this->session("user_id");

        let content = UserWidget::findFirst([
            "user = '".user."'"
            ]
        );

        return content;
    }
}