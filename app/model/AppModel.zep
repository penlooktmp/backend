/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Tin Nguyen <tinntt@penlook.com>
 *  Nam Vo <namvh@penlook.com>
 *
 */
namespace App\Model;

use App\Process;
use App\Model\Table\User;
use App\Model\Table\Language;
use App\Model;

/**
 * App Model
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
class AppModel extends Model
{
	/**
     * AppModel instance
     *
     * @var AppModel
     */
	private static static_app;

	/**
     * Get Instance
     * This is get instance function
     *
     * @return AppModel
     */
    public inline static function getInstance()
    {
        if (!self::static_app) {
            let self::static_app = new AppModel();
        }

        return self::static_app;
    }

	/**
     * Login User
     * This is login user function
     *
     * @param string $email
     * @param string $password
     * @return bool | Phalcon\Mvc\Model\Resultset\Simple
     */
    public inline function loginUser(var email, var password)
    {
    	return User::findFirst([
    		"email 		= '" . email . "' and " .
            "password 	= '" . password . "'",
    		"colunms" 	: "id, email, name, password"
    	]);
    }

	/**
     * Get current language
     * This is get current language function
     *
     * @return bool | Phalcon\Mvc\Model\Row
     */
    public inline function getCurrentLanguage()
    {
        var app_lang, language, language_alias;
        let app_lang = this->session("app_lang");

        if (empty(app_lang)) {
            let app_lang = "en-US"; //hard code.
        }

        let language = explode("-", app_lang); // [en-US]
        let language_alias = language[0];
        return Language::findFirst([
        	"alias 		= '".language_alias."'",
        	"columns" 	: "name"
        ]);
    }

    /**
     * Save register form
     * This is save register form function
     *
     * @param string $first_name
     * @param string $last_name
     * @param string $email
     * @param string $hash
     */
    public inline function saveRegisterForm(var first_name, var last_name, var email, var hash)
    {
        this->session("register_first_name", first_name);
        this->session("register_last_name", last_name);
        this->session("register_email", email);
        this->session("register_hash", hash);
    }

	/**
     * Logout user
     * Delete session and cookie relating to login
     *
     */
    public inline function logoutUser()
    {
        // Remove user in session and cookie
        // this->session("user_id", null);
        // this->session("user_name", null);
        // //$this->cookie('id', 0);
        // //$this->cookie('signature', 0);

        // // Remove user if in Registration
        // this->session("register_name", null);
        // this->session("register_email", null);
        // this->session("register_hash", null);

        // Remove user in session and cookie
        this->session->remove("user_id");
        this->session->remove("user_name");
        this->session->remove("user_first_name");
        this->session->remove("user_last_name");

        // Remove user if in Registration
        this->session->remove("register_first_name");
        this->session->remove("register_last_name");
        this->session->remove("register_email");
        this->session->remove("register_hash");
    }

	/**
     * Remember user
     * This is remember user function, Remember user in cookie for the next login
     *
     * @param string $id
     * @param string $signature
     */
    public inline function rememberUser(int id, string signature)
    {
        //$this->cookie('id', $id);
        //$this->cookie('signature', $signature);
    }

	/**
     * Save user
     * This is save user function, save user to session
     *
     * @param int $id
     * @param string $name
     */
    public inline function saveUser(var id, var name, var first_name, var last_name)
    {
        this->session("user_id", id);
        this->session("user_name", name);
        this->session("user_first_name", first_name);
        this->session("user_last_name", last_name);
    }

    /**
     * Create account
     * This is create account function.
     *
     */
    public inline function createAccount()
    {
        var first_name, last_name, user_info, email, hash, password, user;

        let first_name = this->session("register_first_name");
        let last_name = this->session("register_last_name");
        let email = this->session("register_email");
        let hash  = this->session("register_hash");

        let password = Process::encodePassword(email, hash);

        let user = new User();

        user->save([
            "first_name": first_name,
            "last_name" : last_name,
            "order_name": 1,
        	"email" 	: email,
        	"password" 	: password,
        	"register" 	: date("Y/m/d H:i:s")
        ]);

        let user_info = User::findFirst([
            "email = '" . email . "'",
            "columns" : "id, name, first_name, last_name"
        ]);

        this->saveUser(user_info->id, user_info->name, user_info->first_name, user_info->last_name);
    }

    /**
     * Update Information of User
     *
     * @author Nam Vo <namvh@penlook.com>
     * @param array $data
     */
    public inline function updateUser(var data)
    {
        var user;

        let user = User::findFirst(this->session("user_id"));

        user->save(data);
    }
}