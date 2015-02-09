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

namespace App;

/**
 * Application Router
 *
 * @category   Penlook Application
 * @package    App\Config
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Storage
{

    /**
     * Google Storage
     *
     * @var App\Storage
     */
	public storage;

    /**
     * Cloud storage static instance
     *
     * @var App\Storage
     */
	private static static_storage;

    /**
     * Constructor
     *
     */
    private inline function __construct()
	{

	}

    /**
     * Get router instance
     *
     * @return App\Storage
     */
	public inline static function getInstance()
    {
        if (!self::static_storage) {
            let self::static_storage = new Storage();
        }

        return self::static_storage;
    }

    /**
     * Get storage
     *
     * @return App\Storage
     */
    public inline function getStorage()
    {
    	return this->storage;
    }

}