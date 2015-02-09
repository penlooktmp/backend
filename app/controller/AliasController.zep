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

namespace App\Controller;

use Phalcon\Mvc\View;
use App\Controller;
use App\Model\AliasModel;
use App\Model\Collection\Status;

/**
 * App Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class AliasController extends Controller
{

    /**
     * Index Action
     *
     * @return IndexController forwarding
     */
    public inline function indexAction()
    {
        var alias, model;
        let alias = this->route("alias");
        let model = new AliasModel(alias);

        if ! model->isValid() {
            return this->error(404);
        }

        return this->forward([
             "controller" : model->getController(),
             "action"     : "index",
             "params"     : [
                   "id" : model->getAlias()->{"pid"}
             ]
        ]);
    }

}
