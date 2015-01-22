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

use App\Model\Table\OrgAdmin;
use App\Model;

/**  
 * Organization Model Model
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