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
namespace App;

use App\Service;

/** 
 *  Model 
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
class Model 
{
    /**
     * session service instance
     *
     * @var session
     */
    public session;

    public inline function __construct()
    {
        let this->session = Service::getSession();
    }

    public inline function session(key, value = null)
    {
        if is_null(value) {
            var res;
            let res = this->session->get(key);
            return is_string(res) ? res : false;
        } else {
            this->session->set(key, value);
        }
    }

    public function integrate()
    {

    }
}