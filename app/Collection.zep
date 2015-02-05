/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *      Nam Vo      <namvh@penlook.com>
 *      Loi Nguyen  <loint@penlook.com>
 *      Tin Nguyen  <tinntt@penlook.com>
 */

namespace App;

use Phalcon\Mvc\Collection as Phalcon_Collection;

/**
 * App Collection
 *
 * @category   Penlook Application
 * @package    App\Collection
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Collection extends Phalcon_Collection
{
	/**
     * Initialize Collection
     *
     */
	public inline function initialize()
    {
        this->setConnectionService("mongo");
    }
}
