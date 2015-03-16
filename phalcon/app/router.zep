/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

namespace Phalcon\App;

use Phalcon\Mvc\Router as Phalcon_Router;

/**
 * Application Router
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
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
    private function __construct()
	{
        let this->router = new Phalcon_Router(true);
        this->configureRouter();
	}

    /**
     * Get router instance
     *
     * @return App\Router
     */
	public static function getInstance()
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
    public function configureRouter()
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
    public function getRouter()
    {
    	return this->router;
    }
}