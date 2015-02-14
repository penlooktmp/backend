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

namespace App\Plugin;

/**
 * Application Compiler
 *
 * @category   Penlook Application
 * @package    App\Config
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Compiler
{

    /**
     * Coffee compiler
     *
     */
    public inline static function coffee(coffees, output, server = null)
    {
        string folder, js_content = "", cmd, file_path;
        var coffee, redis;

        let server = "123";

        //let folder = \App\Path::getInstance()->web . "/js/";
        let folder = "/abc";

        for coffee in coffees
        {
            let file_path = folder.coffee;

            if (file_exists(file_path.".coffee") || file_exists(file_path.".js"))
            {
                if(strpos(coffee, "lib/") === false)
                {
                    let cmd = "coffee -c -b ". file_path.".coffee";
                    exec(cmd);
                }

                /*let cmd = "minify ".file_path.".js > ".file_path. ".min.js";
                exec(cmd);
                let file_path = file_path. ".min";*/

                let js_content .= (file_get_contents(file_path.".js"));
                let js_content .= "\n \n";
            }
        }

        let redis = \App\Service::getRedis();
        redis->set(output, js_content);

        return output . ".js";
    }

    /**
     * Less compiler
     *
     */
    public inline static function less(lesses, output, server = null)
    {
        var folder, less_file, redis;
        string less_string = "", cmd, style;

        let folder = "root";
        let server = "3";

        /*let less_config_file = folder . "/css/config.less";
        let less_config = file_get_contents(less_config_file);

        // Modify configuration
        let less_variable = [
            //"img"  : $this->config->img . '/app/app',
            //"font" : $this->config->font
        ];
        var variable, value, replace_variable, regex;
        for variable, value in less_variable
        {
            let replace_variable = "@".$variable.": '".$value."/';";
            let regex = "/^[\@[".$variable."]+:\s\'[a-z0-9\:.\/]+\';/";
            let less_config = preg_replace(regex, replace_variable, less_config);
        }

        file_put_contents(less_config_file, less_config);*/

        for less_file in lesses
        {
            let less_string .= "@import '".less_file. "'; ";
        }

        let style = folder."/css/styles";
        file_put_contents(style.".less", less_string);

        let cmd = "lessc -x --clean-css ".style.".less > " .style.".css";
        system(cmd);
        var styles;
        let styles = file_get_contents(style.".css");

        if empty(styles) {
            echo "Compile error :<br/>";
            echo cmd;
            die();
        }

        let redis = \App\Service::getRedis();
        redis->set(output, styles);

        return output . ".css";
    }
}