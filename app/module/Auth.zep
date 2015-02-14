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

namespace App\Module;

use App\Model;
use App\Model\AppModel;
use App\Model\UserModel;
use App\Process;
use App\Service;

/**
 * Authenticate
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */

class Auth extends Model
{
	/**
     * Check login
     *
     * @var login
     */
	public login;

	/**
     *
     * @var model
     */
	public model;

    /**
     *
     * @var AppModel
     */
	public app;

	public session;

	public inline function __construct()
    {
        var id;

        parent::__construct();
        let this->login = false;
        let id = this->getCurrentUser();

        if id && (id > 0) {
            let this->login = true;
        }

        let this->app = AppModel::getInstance();
    }

    /**
     * Get ID of current user
     *
     * @return int
     */
    public inline function getCurrentUser()
    {
        return this->session("user_id");
    }

    /**
     * Application Logout
     *
     * @return void
     */
    public inline function logout()
    {
        let this->login = false;
        this->app->logoutUser();
    }

    public inline function getSecurityToken()
    {
        return "abcdef";
    }
}