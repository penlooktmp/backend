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
namespace App;

use Phalcon\Mvc\Router as Phalcon_Router;

/**
 * Application Router
 *
 * @category   Penlook Application
 * @package    App\Config
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Router
{

    /**
     * Application Router
     *
     * @var Phalcon\Loader
     */
	public router;

    /**
     * App Router static instance
     *
     * @var App\Router
     */
	private static static_router;

    /**
     * Constructor
     *
     */
    private inline function __construct()
	{
        let this->router = new Phalcon_Router(true);
        this->configureRouter();
	}

    /**
     * Get router instance
     *
     * @return App\Router
     */
	public inline static function getInstance()
    {
        if (!self::static_router) {
            let self::static_router = new Router();
        }

        return self::static_router;
    }

    /**
     * Configure router
     *
     */
    public inline function configureRouter()
    {
        // Default controller namespace
        this->router->setDefaultNamespace("App\\Controller");

        // User
        this->router->add("/u/([0-9]{1,30})", [
                "controller" : "user",
                "action"     : "index",
                "id"         : 1
            ]
        );

        // Organization
        this->router->add("/o/([0-9]{1,30})", [
                "controller" : "organization",
                "action"     : "index",
                "id"         : 1
            ]
        );

        // Skill
        this->router->add("/skill/([0-9]{1,30})", [
               "controller" : "skill",
               "action"     : "description",
               "id"         : 1
           ]
        );

        // Alias
        this->router->add("/([a-z]{1}[a-z0-9._-]{4,29})", [
                "controller" : "alias",
                "action"     : "index",
                "alias"       : 1
            ]
        );

        // Resources
        this->router->add("/res/([a-z0-9]{0,32}).(js|css)", [
                "controller" : "resource",
                "action"     : "index",
                "hash"       : 1,
                "type"       : 2
            ]
        );

        // Restful API
        this->router->add("/syn/([a-z]+)/([a-z0-9-_]{1,30})", [
                "namespace"  : "App\\Api",
                "controller" : 1,
                "action"     : "index",
                "id"         : 2
            ]
        )->via(["GET", "PUT", "PATCH", "DELETE"]);

        this->router->add("/syn/([a-z]+)", [
                "namespace"  : "App\\Api",
                "controller" : 1,
                "action"     : "index"
            ]
        )->via(["GET", "POST"]);
    }

    /**
     * Get router
     *
     * @return App\Router
     */
    public inline function getRouter()
    {
    	return this->router;
    }
}