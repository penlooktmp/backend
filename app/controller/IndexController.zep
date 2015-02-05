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

use App\Controller;
use App\Model\AppModel;

use App\Model\IndexModel;
use App\Model\LanguageModel;
use App\Model\UserModel;
use App\Model\Collection\Like;
use App\Model\Collection\Status;
use App\Model\Collection\Comment;
use App\Module\Auth;
use Phalcon\Mvc\View;

/**
 * Index Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class IndexController extends Controller
{
    /**
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function indexAction()
    {
        var auth, action;
        let auth  = new Auth();

        if auth->login {
            let action = "home";
        } else {
            let action = "welcome";
        }

        return this->forward([
            "action" : action
        ]);
    }

    /**
     * Load Index Page
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function homeAction()
    {
        var auth, app, user;
        let auth  = new Auth();
        let app   = AppModel::getInstance();

        //var introduce;
        //let introduce = this->route("introduce");

        let user = new UserModel(auth->getCurrentUser());

        this->out("user", user->getUser());

        this->js([
            "id"        : user->getUser()->id,
            "name"      : user->getUser()->name,
            "headline"  : user->getUser()->headline,
            "avatar"    : user->getUser()->avatar
        ]);

        this->ng("app");
        this->socket();
    }

    /**
     * Load Welcome Page
     *
     * @author Nam Vo <namvh@penlook.com>
     */
    public inline function welcomeAction()
    {
        var languages;
        let languages = new LanguageModel();
        this->js("languages", languages->getAllLanguages());
        this->ng("penlook-welcome");
    }
}
