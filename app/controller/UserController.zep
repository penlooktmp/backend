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
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
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

        echo allow_edit;
    }
}