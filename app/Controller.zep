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

namespace App;

use Phalcon\Mvc\Controller as Phalcon_Controller;
use App\Translator as Translator;
use App\Module\Auth;

/**
 * Application Controller
 *
 * @category   Penlook Application
 * @package    App\Controller
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Controller extends Phalcon_Controller
{
	/**
    * @var \Phalcon\Mvc\ViewInterface
    */
    private _view;

    /**
     * @var \App\Config
     */
    private _config;

    /**
     * @var \Phalcon\Mvc\RouterInterface
     */
    private _router;

    /**
     * @var \Phalcon\Mvc\DispatcherInterface
     */
    private _dispatcher;

    /**
     * @var \Phalcon\Mvc\UrlInterface
     */
    private _url;

    /**
     * @var \Phalcon\DiInterface
     */
    private _di;

    /**
     * @var \Phalcon\HTTP\RequestInterface
     */
    private _request;

    /**
     * @var \Phalcon\HTTP\ResponseInterface
     */
    private _response;

    /**
     * @var \Phalcon\Flash\Direct
     */
    private _flash;

    /**
     * @var \Phalcon\Flash\Session
     */
    private _flashSession;

    /**
     * @var \Phalcon\Session\AdapterInterface
     */
    private _session;

    /**
     * @var \Phalcon\Http\Response\Cookies
     */
    private _cookies;

    /**
     * @var \Phalcon\Session\Bag
     */
    private _persistent;

    /**
     * @var \Phalcon\Mvc\Model\ManagerInterface
     */
    private _modelsManager;

    /**
     * @var \Phalcon\Mvc\Model\MetadataInterface
     */
    private _modelsMetadata;

    /**
     * @var \Phalcon\Mvc\Model\Transaction\Manager
     `    private _transactionManager;

    /**
     * @var \Phalcon\FilterInterface
     */
    private _filter;

    /**
     * @var \Phalcon\Security
     */
    private _security;

    /**
     * @var \Phalcon\Annotations\Adapter\Memory
     */
    private _annotations;
    public js;
	public auth;
    public asset;

	/**
     * Cache Model
     *
     * @var CacheModel
     */
    public cache;
    public after;
    public less;
    public coffee;

	/**
     * Controller initialize
     *
     */
	public inline function initialize()
	{
        Flow::pick();

	    // Phalcon extender
        this->extender();
        this->init();
	}

    public inline function init()
    {
        // Run AfterExcuteRoute
        let this->after = true;

        // Javascript initialize
        let this->js = this->session("init_js");

        if ! this->js {
            var js;
            let js = new \stdClass();
            let js->root = "";
            let js->css = new \stdClass();
            let js->trans = new \stdClass();
            let this->js = js;
            this->session("init_js", js);
        }

        // Security

        let this->auth = new Auth();

        if (this->auth->login) {
            let js = this->js;
            let js->uid   = this->auth->getCurrentUser();
            let js->token = this->auth->getSecurityToken();
            let this->js  = js;
        }

        // Initialize javascript storage
        this->out([
            "ng" : "",
            "data" : this->js,
            "socket" : false,
            "dev" : this->dev()
        ]);
    }

    /**
     * Controller extender
     *
     */
    public inline function extender()
    {
        let this->_di = this->{"di"};
        let this->_url = this->{"url"};
        let this->_view = this->{"view"};
        let this->_config = this->{"config"};
        let this->_session = this->{"session"};
        let this->_cookies = this->{"cookies"};
        let this->_request = this->{"request"};
        let this->_response = this->{"response"};
        let this->_dispatcher = this->{"dispatcher"};

        let this->asset = this->{"assets"};
    }

    /**
     * View output
     * Assign array of variables to view
     *
     * @param array variables
     */
    public inline function out(variables, value_ = null)
    {
        if is_null(value_) {
            var variable, value;
            for variable, value in variables {
                this->_view->setVar(variable, value);
            }
        } else {
            this->_view->setVar(variables, value_);
        }
    }

    /**
     * Javascript output
     * Assign PHP variable to Javascript variables
     *
     * @param array variables
     */
    public inline function js(variables, value_=null)
    {
        var js;
        let js = this->js;

        if is_null(value_) {
            var variable, value;
            for variable, value in variables {
                let js->{variable} = value;
            }
        } else {
            let js->{variables} = value_;
        }

        let this->js = js;
    }

    /**
     * View pick
     * Pick a layout
     *
     * @param string layout
     */
    public inline function pick(layout)
    {
        this->_view->pick(layout);
    }

    /**
     * Router parameter
     *
     * @param string key
     * @return string | object
     */
    public inline function route(key=null)
    {
        return is_null(key) ? this->_dispatcher->getParam() : this->_dispatcher->getParam(key);
    }

    /**
     * HTTP GET
     *
     * @param string key
     * @return string | object
     */
    public inline function get(key=null)
    {
        return is_null(key) ? this->_request->getQuery() : this->_request->getQuery(key);
    }

    /**
     * HTTP POST
     *
     * @param string key
     * @return string | object
     */
    public inline function post(key=null)
    {
        return is_null(key) ? this->_request->getPost() : this->_request->getPost(key);
    }

    /**
     * HTTP PUT
     *
     * @param string key
     * @return string | object
     */
    public inline function put(key=null)
    {
        return is_null(key) ? this->_request->getPut() : this->_request->getPut(key);
    }

	/**
     * Get service
     *
     * @param string name
     * @return callable
     */
	public inline function service(name)
	{
		return this->_di->getService(name);
	}

    /**
     * Enable realtime
     *
     */
    public inline function socket()
    {
        this->out([
            "socket" : "http://service.penlook.com/socket.io/socket.io.js"
        ]);
    }

	/**
     * Translate multiple language
     *
     * @param string text english sentence
     * @return string multiple languages
     */
	public inline function trans(text)
	{
		var language;
		let language = this->session("language");

        if !language {
            let language = "en_US";
        }

		return Plugin\Translator::getInstance(language)->getTranslator()->query(text);
	}

    /**
     * Session manipulation
     *
     * @param string key
     * @param string value
     * @return array | string
     */
    public inline function session(key = null, value = null)
    {
        if (is_null(key)) {
            return this->_session;
        }

        if is_null(value) {
            var res;
            let res = this->_session->get(key);
            return is_string(res) ? res : false;
        } else {
            this->_session->set(key, value);
        }
    }

    /**
     * get/set cookies
     *
     * @param string key
     * @param string value
     * @return array | string
     */
    public inline function cookies(key = null, value = null)
    {
        if (is_null(key)) {
            return this->_cookies;
        }

        if is_null(value) && this->_cookies->has(key) {
            var res;
            let res = this->_cookies->get(key);
            return is_string(res->getValue()) ? res->getValue() : false;

        } else {
            this->_cookies->set(key, value);
        }
    }

    public inline function dev()
    {
        var app;
        let app = new App();

        if app->debug {
            return true;
        }

        return false;
    }

    /**
     * Action forwarding
     *
     * @param array data
     */
    public inline function forward(data)
    {
        let this->after = false;
        return this->_dispatcher->forward(data);
    }

    /**
     * Redirect to another url
     *
     * @param string url
     */
    public inline function go(url)
    {
        let this->after = false;
        return this->_response->redirect(url);
    }

    /**
     * HTTP Request
     *
     * @return Phalcon\Http\Request
     */
    public inline function request()
    {
        return this->_request;
    }

    /**
     * HTTP Response
     *
     * @return Phalcon\Http\Response
     */
    public inline function response()
    {
        return this->_response;
    }

    /**
     * Error page
     *
     * @params int code
     */
    public inline function error(code)
    {
        this->_response->setStatusCode(code,"");
        this->_view->pick("error/" . code);
    }

    public inline function capcha()
    {
        /*
        var options = new \stdClass();
        options->theme = "custom";
        options->custom_theme_widget = "recaptcha_widget";
        this->js('capcha', options);
        */
    }

    public inline function font()
    {

    }

    /**
     * JSON Output
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    public inline function json(data)
    {
        this->_response->setJsonContent(data);
        this->_response->setHeader("Content-Type", "application/json");
        return this->_response;
    }

    /**
     * Angular JSON
     *
     * @param  string name angular module
     * @return void
     */
    public inline function ng(name)
    {
        this->out([
            "ng" : "data-ng-app=\"". name ."\""
        ]);
    }

	/**
     * Debugger
     *
     * @param mixed variable
     * @return void
     */
	public inline function debug(variable)
	{
		echo "<pre>";
		print_r(variable);
		echo "</pre>";
		die();
	}

    /**
     * Get view
     *
     * @return Phalcon\Mvc\View
     */
    public inline function view()
    {
        return this->_view;
    }

    public function beforeExecuteRoute()
    {

    }

    /**
     * After Execute Router
     *
     * @return void
     */
    public function afterExecuteRoute()
    {
        if ! this->after {
            let this->after = true;
            return;
        }

        // Generate css and js file name based on controller and action name
        var controller, action, css, js;
        let controller = this->_dispatcher->getControllerName();
        let action = this->_dispatcher->getActionName();

        var ignore_controllers = ["resource"];

        if (in_array(controller, ignore_controllers)) {
            return;
        }

        let css = Process::md5(controller.action."css", 5);
        let js  = Process::md5(controller.action."js", 5);

        // Css and Js file name
        this->out([
            "style" :  "/res/" . css,
            "script" : "/res/" . js
        ]);

        if ! this->session("css") {
            this->session("css", css);
        }

        if ! this->session("js") {
            this->session("js", js);
        }

        // Default layout
        this->pick(controller . "/" . action);

        // Compile resources for development mode
        if this->dev() {
            var default_resources, action_resources;

            // Load default resource
            let default_resources = yaml_parse_file(this->_config->path->resources . "/default.yml");
            let action_resources  = yaml_parse_file(this->_config->path->resources . "/" .controller . ".yml");

            var custom_css, custom_js;

            let custom_css = [], custom_js = [];

            let custom_js = explode(" ", default_resources["default"]["js"]);

            if action_resources[action]["css"] {
                let custom_css = explode(" ", action_resources[action]["css"]);
            }

            if action_resources[action]["js"] {
                var file;

                for file in explode(" ", action_resources[action]["js"]) {
                    array_push(custom_js, file);
                }
            }

            var filename, file_path, file_coffee, file_js, javascript, coffee, less, cmd;
            let coffee = [];
            let javascript = [];
            let less = "\n";

            for _, filename in custom_css {
                let filename = this->_config->path->web . "/css/" . filename . ".less";
                if (file_exists(filename)) {
                    let less = less . file_get_contents(filename) . "\n";
                }
            }

            // clean JS files
            let file_path = this->_config->path->web . "/js/modules";
            let cmd = "find " . file_path . " -type f -name '*.js' -exec rm -f {} ;";

            exec(cmd);

            for _, filename in custom_js {
                let file_path = this->_config->path->web . "/js/" . filename;
                let file_coffee = file_path . ".coffee";
                let file_js = file_path . ".js";

                if (file_exists(file_coffee)) {
                    // trick Coffee
                    //let coffee = coffee . file_get_contents(filename) . "\n";
                    let cmd = "coffee -c -b ". file_coffee. " > " . file_js;
                    exec(cmd);
                    let coffee[] = filename;
                } else {
                    if (file_exists(file_js)) {
                        let javascript[] = filename;
                    }
                }
            }

            // Css and Js file name
            this->out([
                "less" : less,
                "coffee" : coffee,
                "js" : javascript
            ]);
        }
    }

    public function renderTemplate(folder, file)
    {
        //return file_get_contents(\App\Path::getInstance(null)->web . "/../app/view/" . folder . "/" . file . ".volt");
    }
}
