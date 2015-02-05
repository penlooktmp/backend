/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *      Nam Vo      <namvh@penlook.com>
 *      Loi Nguyen  <loint@penlook.com>
 *      Tin Nguyen  <tinntt@penlook.com>
 *
 */

namespace App\Controller;

use Phalcon\Mvc\View;
use App\Controller;
use App\Model\OrganizationModel;
use App\Module\Auth;
use App\Model\UserModel;
use App\Model\AppModel;

/**
 * Organization Controller
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
class OrganizationController extends Controller
{

    public organization;

    public user;

    public auth;

    public app;

    public inline function indexAction()
    {
        var oid;
        let oid = this->route("id");

        let this->app   = AppModel::getInstance();
        let this->auth = new Auth();
        let this->organization = new OrganizationModel(oid);

        if this->auth->login {
            let this->user = new UserModel(this->auth->getCurrentUser());
        }


        if ! this->organization->isValid() {
            return this->error(404);
        }

        this->showOrganization();
        //this->createOrganization();
    }

    public inline function showOrganization()
    {
        //var css = [], js = [];
        this->out([
            "user" : this->user->getUser(),
            "login": this->auth->login,
            "isAdmin": true,
            "org" : this->organization->getOrganization(),
            "country": this->organization->getCountry()
        ]);

        /*let css = [
            "lib/bootstrap/bootstrap",
            "lib/config",
            "lib/core",
            "modules/index_header",
            "modules/index_content",
            "modules/org_page",
            "modules/org_test",
            "modules/index_flow"
        ];

        let js = [
            "lib/typehead",
            "lib/underscore",
            "lib/search",
            "modules/header",
            "modules/post",
            "modules/org",
            "modules/upload"
        ];

        this->res("css", css, true, true);
        this->res("js", js, true, true);
        */

        this->js([
            "org_name"  : this->organization->getOrganization()->name,
            "org_logo"  : this->organization->getOrganization()->logo,
            "org_id"    : this->organization->getOrganization()->id,
            "id"        : this->user->getUser()->id,
            "name"      : this->user->getUser()->name,
            "headline"  : this->user->getUser()->headline,
            "avatar"    : this->user->getUser()->avatar
        ]);

        this->ng("app");
        this->pick("org/page/layout");

    }

    public inline function createOrganization()
    {
        this->out([
            "next_step": 1
        ]);

        /*this->res("css", [
            "lib/bootstrap/bootstrap",
            "lib/config",
            "lib/core",
            "modules/index_header",
            "modules/index_content",
            "modules/org_create",
            "modules/app_footer"
        ], true, true);
        */
        this->pick("org/create/layout");
    }
}