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
namespace App\Module;

use App\Model;
use App\Model\AppModel;
use App\Model\UserModel;
use App\Process;
use App\Service;

/**
 * Authenticate
 *
 * @category   Penlook Application
 * @package    App\Config
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */

class Auth extends Model
{
	/**
     * Check login
     *
     * @var login
     */
	public login;

	/**
     *
     * @var model
     */
	public model;

    /**
     *
     * @var AppModel
     */
	public app;

	public session;

	public inline function __construct()
    {
        var id;

        parent::__construct();
        let this->login = false;
        let id = this->getCurrentUser();

        if id && (id > 0) {
            let this->login = true;
        }

        let this->app = AppModel::getInstance();
    }

    /**
     * Get ID of current user
     *
     * @return int
     */
    public inline function getCurrentUser()
    {
        return this->session("user_id");
    }

    /**
     * Login with username and password
     *
     * @param  string email
     * @param  string hash_password
     * @param  bool remember
     * @return bool
     */
    public inline function login(email, hash_password, remember = false)
    {
        if this->login {
            return true;
        }

        var encode_password, user, users;

        let encode_password = Process::encodePassword(email, hash_password);
        let users = this->app->loginUser(email, encode_password);

        if users != false {
            let user = new UserModel(users->id);

            // Save user to Session
            this->app->saveUser(
                user->getUser()->id,
                user->getUser()->name,
                user->getUser()->first_name,
                user->getUser()->last_name
            );

            // Remember me in cookie for next login
            if remember {
                this->app->rememberUser(user->getUser()->id, user->getSignature());
            }

            let this->login = true;
        }

        return this->login;
    }

    /**
     * Application Logout
     *
     * @return void
     */
    public inline function logout()
    {
        let this->login = false;
        this->app->logoutUser();
    }

    public inline function getSecurityToken()
    {
        return "abcdef";
    }
}