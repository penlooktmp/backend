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

use App\Model\Table\Alias;
use App\Model;

/**
 * Alias Model
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
class AliasModel extends Model
{
    /**
     * AliasTable instance
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var alias
     */
    private alias;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $alias
     */
    public function __construct(string alias)
    {
        parent::__construct();
        let this->alias = Alias::findFirst([
            "name = '".alias."'"
        ]);
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public function getAlias()
    {
        return this->alias;
    }
    /**
     * Is valid
     * This is check valid function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public function isValid()
    {
        return this->alias ? true : false;
    }

    /**
     * Get controller
     * This is get controller function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getController()
    {
        var controller;
        let controller = false;

        switch (this->alias->type) {
            case "u": let controller = "User";
                break;
            case "o": let controller = "Organization";
                break;
            case "s": let controller = "Skill";
                break;
        }

        return controller ? controller : false;
    }
}
