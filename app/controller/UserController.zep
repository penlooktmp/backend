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

use App\Controller;
use App\Model\AppModel;
use App\Model\LanguageModel;
use App\Model\ProfileModel;
use App\Model\UserModel;
use App\Module\Auth;
use Phalcon\Mvc\View;

/**
 * User Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class UserController extends Controller
{
    /**
     * Global user
     *
     * @var UserModel
     */
    public user;

    /**
     * @var AppModel
     */
    public app;

    /**
     * @var Auth
     */
    public auth;

    /**
     * Current user
     *
     *  @var UserModel
     */
    public currentUser;

    public languages;

    /**
     * Dispatch to User Page or Profile Page
     *
     * @return User/user | User/profile
     */
    public function indexAction()
    {
        var allow_edit, id;

        let id = this->route("id");
        let this->auth = new Auth();
        let this->app = AppModel::getInstance();

        let this->currentUser = new UserModel(id);
        let this->user = new UserModel(this->auth->getCurrentUser());
        let this->languages = new LanguageModel();

        if ! this->user->isValid() {
            return this->error(404);
        }

        let allow_edit = true;

        if !this->auth->getCurrentUser() || (this->auth->getCurrentUser() != id) {
            let allow_edit = false;
        }

        return allow_edit ? this->user() : this->profile();
    }

    /**
     * Page of Global User, they can edit our information
     */
    public inline function user()
    {
        var profile, widgets, socials;

        let profile = new ProfileModel();
        let widgets = profile->getWidgets();

        this->js([
            "ng"        : "user",
            "languages" : this->languages->getAllLanguages(),
            "widgets"   : widgets
        ]);

        // Global layout

        /*
        $this->out->title = $this->user->getTitle();
        $this->out->description = $this->user->getDescription();
        */

        /*this->res("css", [
            "modules/index_header",
            "modules/app_search",
            "modules/app_languages",
            "modules/user_social_widget",
            "modules/user_slogan",
            "modules/user_edit_content",
            "modules/user_information",
            "modules/user_jcrop",
            "modules/user_profile",
            "modules/user_widget",
            "modules/user_upload",
            "modules/app_footer"
        ], true, true);

        this->res("js", [
            "lib/jquery.ui",
            "lib/typehead",
            "lib/underscore",
            "lib/search",
            "modules/header",
            "modules/func",
            "modules/user",
            "modules/language",
            "modules/profile",
            "lib/image",
            //"lib/dragdrop",
            "lib/widget"
        ], true, true);*/

        let socials = this->user->getSocial([
            "facebook",
            "skype",
            "linkedin",
            "github"
        ]);

        this->out([
            "title"       : this->user->getTitle(),
            "description" : this->user->getDescription(),
            "user"        : this->user->getUser(),
            "currentUser" : this->currentUser->getUser(),
            "socials"     : socials->toArray(),
            "widgets"     : widgets
        ]);

        this->ng("user");

        this->pick("user/layout");
    }

    public inline function profile()
    {
        //var css = [], js = [];

        /*let css = [
            "modules/app_languages",
            "modules/user_social_widget",
            "modules/user_slogan",
            "modules/user_edit_content",
            "modules/user_information",
            "modules/user_jcrop",
            "modules/user_profile",
            "modules/user_widget",
            "modules/user_upload",
            "modules/app_footer"
        ];

        let js = [
            "lib/typehead",
            "lib/underscore",
            "lib/search",
            "modules/header",
            "modules/func",
            "modules/user",
            "modules/language",
            "modules/profile"
        ];*/

        if this->auth->login {
            /*let css[] = "modules/index_header";
            let css[] = "modules/app_search";*/

            this->out([
                "isLogin"     : true,
                "user"        : this->user->getUser(),
                "currentUser" : this->currentUser->getUser()
            ]);
        } else {
            /*let css[] = "modules/index_header";
            let css[] = "modules/app_search";*/
            /*let css[] = "modules/app_header";
            let css[] = "modules/welcome_login_form";*/

            //let js[] = "modules/app";

            this->out([
                "isLogin"     : false,
                "currentUser" : this->currentUser->getUser()
            ]);
        }


        /*this->res("css", css, true, true);
        this->res("js", js, true, true);
        */

        this->ng("user");

        this->pick("profile/layout");
    }
}