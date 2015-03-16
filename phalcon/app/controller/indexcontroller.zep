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

namespace Phalcon\App\Controller;

use Phalcon\App\Controller;
use Phalcon\App\Model\AppModel;
use Phalcon\App\Model\IndexModel;
use Phalcon\App\Model\LanguageModel;
use Phalcon\App\Model\UserModel;
use Phalcon\App\Module\Auth;
use Phalcon\App\Flow;
use Phalcon\Mvc\View;

/**
 * Index Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class IndexController extends Controller
{
    /**
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function indexAction()
    {
        Flow::pick("Index action");

        var auth, action;
        let auth  = new Auth();

        if auth->login {
            let action = "home";
        } else {
            let action = "welcome";
        }

        return this->forward([
            "action" : action
        ]);
    }

    /**
     * Load Index Page
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function homeAction()
    {
        var auth, app, user;
        let auth  = new Auth();
        let app   = AppModel::getInstance();

        //var introduce;
        //let introduce = this->route("introduce");

        let user = new UserModel(auth->getCurrentUser());

        this->out("user", user->getUser());

        this->js([
            "id"        : user->getUser()->id,
            "name"      : user->getUser()->name,
            "headline"  : user->getUser()->headline,
            "avatar"    : user->getUser()->avatar
        ]);

        this->ng("app");
        this->socket();
    }

    /**
     * Load Welcome Page
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function welcomeAction()
    {
        var languages;
        let languages = new LanguageModel();
        this->js("languages", languages->getAllLanguages());
        this->ng("penlook-welcome");
    }
}