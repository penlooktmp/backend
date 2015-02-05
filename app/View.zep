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