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
namespace App\Controller;

use Phalcon\Mvc\View;
use App\Controller;
use App\Model\Collection\Status;
use App\Model\Table\User;
use App\Model\AppModel;
use App\Module\Auth;
use App\Model\AjaxModel;

/**
 * Index Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class TestController extends Controller
{
    public function beforeExecuteRoute()
    {

    }

    /**
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public function cssAction()
    {
        /*this->res("css", [
            "lib/bootstrap/bootstrap",
            "lib/config",
            "lib/core",
            "modules/app_header",
            "modules/app_introduce",
            "modules/app_languages",
            "modules/app_footer",
            "modules/welcome_introduce",
            "modules/welcome_login_form",
            "modules/welcome_register",
            "modules/welcome_register_form"
        ], true, true);*/
    }

    public function errorAction()
    {
        return this->error(404);
    }

    public function testAction() {
        var testmodel;
        let testmodel = AjaxModel::getInstance();
        testmodel->updateAvatar(null,"1");
        die();
        /*var status;

        let status = new Status();

        let status->name = "Hello World";
        let status->type = "crazy";
        let status->data = "HSAJKDHSAJDHKJSAHKDJAH";

        if (status->save() == false) {
            echo "Cannot save";
        }
        else {
            echo "Successfully!";
        }*/
    }

    public function mediaAction()
    {
    }

    public function loginAction()
    {
        
    }

    public function trollAction()
    {
        this->ng("troll");
        //this->socket(true);
    }
}
