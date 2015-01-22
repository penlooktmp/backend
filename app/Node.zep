/*
 * Copyright (C) 2014 Penlook  
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Loi Nguyen <loint@penlook.com> 
 *  
 */
namespace App;

/**  
 * PHP - Node Communication
 *     
 * @category   Penlook Application  
 * @package    App   
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial 
 * @version    1.0  
 * @link       http://penlook.com
 * @since      Class available since Release 1.0 
 */ 
class Node
{
	/**
     * Redis
     * 
     * @var \Redis
     */
	public redis; 

	public function __construct()
	{

	}

	public function emit(event, data)
	{

	}
}