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