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
namespace App\Plugin;

use Phalcon\Mvc\View\Engine\Volt as VoltEngine;

/**
 * Plugin Volt
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

class Volt extends VoltEngine
{
    /**
     * Renders a view using the template engine
     *
     * @param string  $templatePath
     * @param array   $params
     * @param boolean $mustClean
     */
    public inline function render(string! templatePath, var params, boolean mustClean = false)
    {
        var cache, cache_file,template_name;

        let cache = \App\Path::getInstance()->cache;
        let template_name = str_replace("/", "_", templatePath);
        let cache_file = cache . "/min" . template_name . ".php";

        var compiler, key, value;

        if mustClean {
            ob_start();
        }

        var app;
        let app = \App\App::getInstance();

        if app->debug {
            var template, template_file;

            let compiler = this->getCompiler();
            compiler->compile(templatePath);

            let template_file = compiler->getCompiledTemplatePath();
            let template = file_get_contents(template_file);
            //let template = \App\Plugin\Tidy::compress(template);
            file_put_contents(cache_file, template);
        }

        /**
         * Export the variables the current symbol table
         */
        if typeof params == "array" {
            for key, value in params {
                let {key} = value;
            }
        }

        require cache_file;

        if mustClean {
            this->{"_view"}->setContent(ob_get_contents());
            ob_clean();
        }
    }

}