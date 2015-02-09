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

/**
 * Application View
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
class View
{
    /**
     * Translator for view
     *
     * @return string text multiple language
     */
	public inline static function trans(text)
	{
		var session, language;
		let session  = Service::getSession();
        let language = session->get("language");

        if language==null {
            let language = "en_US";
        }

	    return Plugin\Translator::getInstance("\"" . language . "\"")->getTranslator()->query(text);
	}

    /**
     * Translator for view
     *
     * @return string text multiple language
     */
	public inline static function site(url)
	{
	    return "http://" . _SERVER["SERVER_NAME"]. "/". url;
	}

    /**
     * JSON for view
     *
     * @return string json data
     */
	public inline static function json(arr)
	{
	    if (is_object(arr)) {
	        var json;
            let json = json_encode(arr);
            return "<script>var json = ".json.";</script>";
	    }
	}

    /**
     * Create image link
     *
     * @param string img
     * @return string
     */
    public inline static function img(image)
    {
        if image != "" && strpos("http", image) {
            return image;
        }
        var storage, link;

        let storage = Config::getInstance()->path["site"]["static"];
        let link = "http://" . storage . "/img/" .image;
        return link;
    }

    /**
     * Create css link
     *
     * @param string css
     * @return string
     */
    public inline static function css(style)
    {
        if empty(style) {
            return "";
        }

        let style = "<link rel=\"stylesheet\" type=\"text/css\" href=\"". style .".css\" />";
        return style;
    }

    /**
     * Lazy
     *
     * @param string script
     * @return string
     */
    public inline static function js(script)
    {
        if ! script {
            return "";
        }

        let script = "<script>(function(){function e(){var e=document.createElement('script');e.type='text/javascript';e.async=true;e.src='". script .".js';var t=document.getElementsByTagName('script')[0];t.parentNode.insertBefore(e,t)}if(window.attachEvent){window.attachEvent('onload',e);}else {window.addEventListener('load',e,false)}})()</script>";
        return script;
    }

	public inline static function less(resources)
	{
        var files, styles, path, file, ext;
        let files = resources->getResources();
        let styles = "";

        for _, file in files {
            let path = file->getPath();
            let ext = Process::getFileType(path);
            let styles .= "<link rel=\"stylesheet/" . ext . "\" type=\"text/css\" href=\"/". path ."\" />";
        }

        return styles;
	}

    public inline static function coffee(resources)
    {
        var files, styles, file;
        let files = resources;
        let styles = "";

        for _, file in files {
            let styles .= "<script src=\"/js/". file .".js\"></script>";
        }

        return styles;
    }

}