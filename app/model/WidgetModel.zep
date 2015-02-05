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
use Phalcon\Mvc\View\Simple;

/**
 * Widget Model
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