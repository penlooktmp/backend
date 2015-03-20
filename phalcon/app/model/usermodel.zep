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

namespace Phalcon\App\Model;

use Phalcon\App\Model\Table\Country;
use Phalcon\App\Model\Table\User;
use Phalcon\App\Model\Table\Social;
use Phalcon\App\Model;

/**
 * User Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class UserModel extends Model
{
    /**
     * UserTable instance
     *
     * @var user
     */
    private user;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public function __construct(id)
    {
        parent::__construct();
        if id {
            let this->user = User::findFirst([
                "id = '".id."'"
            ]);
        }
    }

    /**
     * Get User from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public function getUser()
    {
        return this->user;
    }
    /**
     * Is valid
     * This is check valid user function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public function isValid()
    {
        return is_object(this->user) ? true : false;
    }

    /**
     * Get title
     * This is get title function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getTitle()
    {
        return this->user->name;
    }

    /**
     * Get description
     * This is get description function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getDescription()
    {
        return this->user->slogan;
    }

    /**
     * Get nationality
     * This is get nationality function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getNationality(var alias = false)
    {
        var nationality;
        let nationality = Country::findFirst([
            "id = '".this->user->nationality."'"
        ]);

        return alias ? nationality->{"alias"} : nationality->{"name"};
    }

    /**
     * Get social
     * This is get social function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return object
     */
    public function getSocial(var list)
    {
        return Social::findFirst([
            "user_id = '".this->user->id."'",
            "columns" : list
        ]);
    }

    /**
     * Get signature
     * This is get signature function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getSignature()
    {
        var str, sha1;
        let str = this->user->name . this->user->password . this->user->email . _SERVER["HTTP_USER_AGENT"] . _SERVER["REMOTE_ADDR"];
        let sha1 = sha1(str);

        return hash("sha512", sha1) . hash("sha384", sha1);
    }

    /**
     * Get fullname
     * This is get fullname function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getFullName()
    {
        return this->user->name;
    }

    /**
     * Get headline
     * This is get headline function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getHeadLine()
    {
        return this->user->headline;
    }

    /**
     * Get professional
     * This is get professional function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getProfessional()
    {
        return "Computer Programming";
    }

    /**
     * Get Current
     * This is get current function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getCurrent()
    {
        return this->user->current;
    }

    /**
     * Get previous
     * This is get privious function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getPrevious()
    {
        return this->user->previous;
    }

    /**
     * Get education
     * This is get education function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getEducation()
    {
        return this->user->education;
    }

    /**
     * Get email
     * This is get email function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getEmail()
    {
        return this->user->email;
    }

    /**
     * Get alias
     * This is get alias function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getAlias()
    {
        return this->user->alias;
    }

    /**
     * Get avatar
     * This is get avatar function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getAvatar()
    {
        var avatar;
        let avatar = "default.jpg";

        return this->user->avatar ? this->user->avatar : avatar;
    }

    /**
     * Get language
     * This is get language function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getLanguage()
    {

    }

    /**
     * Get country
     * This is get country function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getCountry_Alias()
    {
        return "vietnam";
    }

    /**
     * Get register day
     * This is get register day function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getRegisterDate()
    {

    }

}