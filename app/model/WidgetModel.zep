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

use App\Model\Table\Widget;
use App\Model;
use Phalcon\Mvc\View\Simple;

/**
 * Widget Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class WidgetModel extends Model
{
    /**
     * Widget View
     *
     * @var ViewModel
     */

    public view;

    /**
     * Widget layout folder
     *
     * @var type
     */
    public layout_folder;

    private widget;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public inline function __construct(var id)
    {
        parent::__construct();

        if (is_numeric(id)) {
            let this->widget = Widget::findFirst([
                "id = '" . id . "'"
                ]
            );
        } else {
            let this->widget = Widget::findFirst([
                "alias = '" . id . "'"
                ]
            );
        }

        let this->layout_folder = "widget";

        // Integrate widget's informations into this object as properties
        /*if ($widget) {
            $this->add($widget);
            $this->view = new ViewModel();
        } else {
            unset($this->id);
            $this->enable = false;
        }*/
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getData()
    {
        return this->widget;
    }

    /**
     * Is Enable
     * This is check enable widget function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public inline function isEnable()
    {
        return (this->widget->enable == 1) ? true : false;
    }

    /**
     * Set Template
     * This is set template function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $widget_name
     */
    public inline function setTemplate(var widget_name)
    {
        echo widget_name;
        // this->view->setContent(this->layout_folder . "/" . widget_name);
    }

    /**
     * Create
     * This is create function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     */
    public inline function create()
    {
        return this->view;
    }

    public inline function getContent()
    {
        return this->view->render("test");
    }
}