/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Nam Vo <namvh@penlook.com>
 *
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
 * @author     Nam Vo <namvh@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class AliasController extends Controller
{

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
