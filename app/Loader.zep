/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *      Nam Vo      <namvh@penlook.com>
 *      Loi Nguyen  <loint@penlook.com>
 *      Tin Nguyen  <tinntt@penlook.com>
 */

namespace App;

use Phalcon\Loader as Phalcon_Loader;

/**
 * Application Loader
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
class Loader
{

    /**
     * Application Loader
     *
     * @var Phalcon\Loader
     */
	public loader;

    /**
     * Loader Instance
     *
     * @var Phalcon\Loader
     */
	private static static_loader;

    /**
     * Constructor
     *
     */
    private function __construct()
	{
        let this->loader = new Phalcon_Loader();

        // Register for namespaces
        this->registerNamespaces();
	}

    /**
     * Get loader instance
     *
     * @var App\Loader
     */
	public inline static function getInstance()
    {
        if (!self::static_loader) {
            let self::static_loader = new Loader();
        }

        return self::static_loader;
    }

    /**
     * Get additional namespaces
     *
     * @return array
     */
    public inline function getNamespaces()
    {
        var config, namespaces;
        let config = Config::getInstance()->getConfig();

        let namespaces = [
        ];

        return namespaces;
    }

    /**
     * Register namespace
     *
     */
    public inline function registerNamespaces()
    {
        this->loader->registerNamespaces(this->getNamespaces());
    }

    /**
     * Get loader
     *
     * @var Phalcon\Loader
     */
    public inline function getLoader()
    {
    	return this->loader->register();
    }

}