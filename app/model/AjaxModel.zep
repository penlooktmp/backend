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

    public function searchUser(string keyword)
    {
        /*
        $this->more($this->select()
                         ->from('user')
                         ->where(

                          )
        );
        */
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