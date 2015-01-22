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
use App\Model\SearchModel;

/**
 * Ajax Controller
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
class AjaxController extends Controller
{

    public function searchAction()
    {

    }

    public function statusAction()
    {
        var status;
        let status = this->post();
        print_r(status);
    }
}
