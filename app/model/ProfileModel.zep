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

use App\Model\Table\Widget;
use App\Model;

/**  
 * Profile Model
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
class ProfileModel extends Model
{	
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     */
    public inline function __construct()
    {
        parent::__construct();
    }

    /**
     * Get Widgets
     * This is get Widgets function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array object
     */
    public inline function getWidgets()
    {
        return Widget::find([
            "enable = 1",
            "columns" : "id, name"
        ])->toArray();
    }
}