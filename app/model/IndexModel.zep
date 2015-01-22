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
use App\Model;


/**  
 * Index Model
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
class IndexModel extends Model
{	
    /**
     * IndexModel instance
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var IndexModel
     */
	private static static_index;
	
	/**
     * Get Instance
     * This is get instance function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return IndexModel
     */
    public inline static function getInstance()
    {
        if (!self::static_index) {
            let self::static_index = new IndexModel();
        }

        return self::static_index;
    }

    /**
     * Get Users
     * This is get users function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array Object
     */
    public inline function getUsers()
    {
        return User::find([
            "columns" : "name, email, alias"
        ])->toArray();
    }
}