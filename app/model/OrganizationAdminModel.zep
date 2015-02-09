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

use App\Model\Table\OrgAdmin;
use App\Model;

/**
 * Organization Model Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class OrganizationAdminModel extends Model
{
    /**
     * Organization id instance
     *
     * @var id
     */
    public id;
    /**
     * organization type
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var $type
     */
    public type;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     * @param string $type
     * @param string $user_id
     */
    public inline function __construct(var id, var type)
    {
        parent::__construct();

        let this->id     = id;
        let this->type   = type;
    }

    /**
     * Get Admin
     * This is get admin function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Object
     */
    public inline function getAdmin()
    {
        return OrgAdmin::find([
            "org_id     = '".this->id."' AND ".
            "org_type   = '".this->type."'",
            "columns"   : "user_id"
        ])->toArray();
    }

    /**
     * Add Admin
     * This is get all skill function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     */
    public inline function addAdmin(var user_id)
    {
        var admin;
        let admin = new OrgAdmin();
        admin->save([
            "org_id"    : this->id,
            "org_type"  : this->type,
            "user_id"   : user_id
        ]);
    }
}