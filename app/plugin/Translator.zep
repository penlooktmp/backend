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
namespace App\Plugin;

use Phalcon\Translate\Adapter\Gettext as Phalcon_Translator;
/**
 * Application Translator
 *
 * @category   Penlook Application
 * @package    App\Collection
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Translator
{
	/**
     * Translator
     *
     * @var Phalcon\Config
     */
    private translator;

    /**
     * Config Instance
     *
     * @var App\Config
     */
	private static static_translators;

    /**
     * Constructor
     *
     */
    private inline function __construct(language)
	{
        var path;
        let path = \App\Path::getInstance();
        let this->translator = new Phalcon_Translator([
                                   "locale": language . ".utf8",
                                   "defaultDomain": "message",
                                   "directory" : path->root . "/public/lang"
                               ]);
	}

    /**
     * Get translator instance
     *
     * @return App\Translator
     */
	public inline static function getInstance(language)
    {
        if (!isset(self::static_translators[language])) {
            let self::static_translators[language] = new Translator(language);
        }

        return self::static_translators[language];
    }

    public inline function getTranslator()
    {
        return this->translator;
    }


}
