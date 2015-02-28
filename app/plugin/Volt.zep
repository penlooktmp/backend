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

namespace App\Plugin;

use Phalcon\Mvc\View\Engine\Volt as VoltEngine;

/**
 * Plugin Volt
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
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

        //let cache = \App\Path::getInstance()->cache;
        let cache = "public/cache";
        let template_name = str_replace("/", "_", templatePath);
        let cache_file = cache . "/min" . template_name . ".php";

        var compiler, key, value;

        if mustClean {
            ob_start();
        }

        var app;
        let app = new App();

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