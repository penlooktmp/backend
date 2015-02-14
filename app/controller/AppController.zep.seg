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
use App\Module\Auth;
use App\Controller;
use App\Model\AppModel;
use App\Model\CountryModel;
use App\Model\LanguageModel;
use App\Module\Auth;
use Phalcon\Mvc\View;

/**
 * App Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class AppController extends Controller
{
    /**
     * App Model
     * @var AppModel
     */
    public app;

    /**
     * Authentication
     * @var Auth
     */
     public auth;

    /**
     * Before Execute Event
     * Initialize app model and authentication
     *
     * @return void
     */
    public inline function beforeExecuteRoute()
    {
        let this->app = AppModel::getInstance();
        let this->auth = new Auth();
    }

    /**
     * Index action
     * Index page is not available
     *
     * @router /app/
     * @return error 404
     */
    public inline function indexAction()
    {
        return this->error(404);
    }

    /**
     * About action
     * Introduce page
     *
     * @router /app/about
     * @return void
     */
    public inline function aboutAction()
    {
        var languages;

        let languages = new LanguageModel();

        this->js("languages", languages->getAllLanguages());
        this->ng("app");
    }

    /**
     * Developer action
     * Page for developers
     *
     * @router /app/developer
     * @return void
     */
    public inline function developersAction()
    {
        var languages;

        let languages = new LanguageModel();

        this->js("languages", languages->getAllLanguages());
        this->ng("app");
    }

    /**
     * Volunteer action
     * Page for Volunteers
     *
     * @router /app/volunteer
     * @return void
     */
    public inline function volunteersAction()
    {
        var languages;

        let languages = new LanguageModel();

        this->js("languages", languages->getAllLanguages());
        this->ng("app");
    }

    public inline function careersAction()
    {
        var languages;

        let languages = new LanguageModel();

        this->js("languages", languages->getAllLanguages());
        this->ng("app");
    }

    public inline function forgotAction()
    {
        var languages;

        let languages = new LanguageModel();

        this->js("languages", languages->getAllLanguages());
        this->ng("app");
    }

    /**
     * Handle registration
     *
     */
    public inline function registerAction()
    {
        var finish;

        let finish = this->post("register_finish");

        if (is_null(finish)) {
            var first_name, last_name, email, hash, countries, languages;

            let first_name  = this->post("register_first_name");
            let last_name = this->post("register_last_name");
            let email = this->post("register_email");
            let hash  = this->post("register_hash");

            // echo first_name . " ~ " . last_name . " ~ " . email . " ~  " . hash;
            // die();

            // this->app->saveRegisterForm(first_name, last_name, email, hash);
            // this->app->createAccount();

            let countries = new CountryModel();
            let languages = new LanguageModel();

            this->js([
                "countries" : countries->getAllCountries(),
                "languages" : languages->getAllLanguages()
            ]);

            this->ng("penlook-register");

        } else {

            var  question, answer, country, language;

            let question = this->post("register-question");
            let answer   = this->post("register-answer");
            let country  = this->post("register-country");
            let language = this->post("register-language");

            this->app->updateUser([
                "question"      : question,
                "answer"        : answer,
                "nationality"   : country,
                "language"      : language
            ]);

            this->go("app/introduce");
        }
    }

    /**
     * Go to Index Page with an introduce
     *
     * @return Index/indexAction | App/aboutAction
     */
    public inline function introduceAction()
    {
        if this->auth->login {
            return this->forward([
                "controller" : "Index",
                "action"     : "index",
                "params"     : [
                    "introduce" : true
                ]
            ]);
        }

        return this->go("/app/about");
    }

    /**
     * Handle login
     *
     */
    public inline function loginAction()
    {

        var email, hash, remember;

        let email = this->post("header_user");
        let hash  = this->post("header_hash");
        let remember = this->post("header_remenber") == NULL ? false : true;

        if is_string(email) && (this->auth->login(email, hash, remember)) {
            // if this->app->checkActive(email) {
            return this->go("");
            // } else {
            //     this->registerAction();
            // }
        }

        var languages;
        let languages = new LanguageModel();
        this->js("languages", languages->getAllLanguages());
        this->ng("penlook-login");
    }

    public inline function settingsAction()
    {
        return this->error(404);
    }

    public inline function paymentAction()
    {
        var countries, languages;

        let countries = new CountryModel();
        let languages = new LanguageModel();

        this->js([
            "countries" : countries->getAllCountries(),
            "languages" : languages->getAllLanguages()
        ]);

        /*this->res("css", [
            "modules/app_header",
            "modules/app_introduce",
            "modules/app_languages",
            "modules/app_steps",
            "modules/app_confirm_register",
            "modules/welcome_login_form",
            "modules/app_footer"
        ]);

        this->res("js", [
            "modules/app",
            "modules/language",
            "lib/bootstrap-combobox"
        ]);*/

        this->ng("app");

        this->pick("app/payment");
    }

    /**
     * Handle logout
     *
     */
    public inline function logoutAction()
    {
        this->auth->logout();
        this->go("");
    }
}