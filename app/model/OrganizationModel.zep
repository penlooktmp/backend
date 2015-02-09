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

use App\Model\Table\Country;
use App\Model\Table\Org;
use App\Model;

/**
 * Organization Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class OrganizationModel extends Model
{
    /**
     * OrgTable instance
     *
     * @var Org
     */
    private org;
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public inline function __construct(id)
    {
        parent::__construct();

        let this->org = Org::findFirst([
            "id = ".id
        ]);
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getOrganization()
    {
        return this->org;
    }

    /**
     * Is Valid
     * This is check valid id function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public inline function isValid()
    {
        return this->org ? true : false;
    }

    /**
     * Get Nationality
     * This is get nationality function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param bool $alias
     * @return string
     */
    public inline function getCountry()
    {
        var country;
        let country = Country::findFirst([
            "id = '".this->org->nationality."'"
        ]);

        return country;
    }

    /**
     * Add Organization
     * This is add organization function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $parent_name
     * @param string $org_name
     * @param string $nationality
     * @param string $type
     * @return int
     */
    public inline function addOrganization(var parent_name, var org_name, var nationality, var type)
    {
        var new_org;
        let new_org = new Org();
        new_org->save([
            "name"          : org_name,
            "header"        : parent_name,
            "type"          : type,
            "nationality"   : nationality
        ]);
        return new_org;
    }

    /**
     * Update Organization
     * This is update organization function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     * @param string $subtitle
     * @param string $email
     * @param string $address
     * @param string $phone
     * @param string $website
     * @param string $description
     * @param string $image
     * @param string $color
     */
    public inline function updateOrganization(var id, var subtitle, var address, var phone, var website, var description, var image, var color)
    {
        var org;
        let org = Org::findFirst([
            "id = '".id."'"
        ]);
        org->save([
            "sub"           : subtitle,
            "phone"         : phone,
            "website"       : website,
            "address"       : address,
            "description"   : description,
            "image"         : image,
            "color"         : color
        ]);
    }
}