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
use App\Model\Table\Region;
use App\Model;


/**  
 * Country Model
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
class CountryModel extends Model
{	
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public inline function __construct(id = null)
    {
        parent::__construct();
    }

    /**
     * Get All Countries
     * This is get all countries function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array object
     */
    public inline function getAllCountries()
    {
        return Country::find()->toArray();
    }

     /**
     * Get All Regions
     * This is get all regions function
     * 
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array object
     */
    public inline function getAllRegions()
    {
        return Region::find([
            "columns" : "id, name"
        ])->toArray();
    }
}