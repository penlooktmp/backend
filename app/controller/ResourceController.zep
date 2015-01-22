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

use App\Controller;
use Phalcon\Http\Response;

/**
 * Resource Controller
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
class ResourceController extends Controller
{
    public function get()
    {
        var redis, hash, type, content;
        let hash = this->route("hash");
        let type = this->route("type");

        let redis = \App\Service::getRedis();
        let content = redis->get(hash);

        if ! content {
            echo "Need to build cache !";
            die();
        }

        var response, content_type;
        let response = this->response();
        let content_type = "text/plain";

        switch (type) {
            case "css":
                let content_type = "text/css";
            break;

            case "js":
                let content_type = "application/javascript";
            break;
        }

        response->setHeader("Content-Type", content_type);
        response->setStatusCode(200, "OK");
        response->setContent(content);
        return response;
    }

    public function indexAction()
    {
        return this->get();
    }
}