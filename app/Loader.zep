/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

namespace App;

use Phalcon\Loader as Phalcon_Loader;

/**
 * Application Loader
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Loader
{

    /**
     * Application Loader
     *
     * @var Phalcon\Loader
     */
	public loader;

    /**
     * Constructor
     *
     */
    private function __construct()
	{
        let this->loader = new Phalcon_Loader();
	}

    /**
     * Get additional namespaces
     *
     * @return array
     */
    public function getNamespaces()
    {
        var config, namespaces;
        let config = Config::getInstance()->getConfig();

        let namespaces = [
        ];

        return namespaces;
    }

    /**
     * Register namespace
     *
     */
    public function registerNamespaces()
    {
        this->loader->registerNamespaces(this->getNamespaces());
    }

    /**
     * Get loader
     *
     * @var Phalcon\Loader
     */
    public function getLoader()
    {
    	return this->loader;
    }

}