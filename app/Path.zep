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
 * Application Path
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
class Path
{
	/**
     * Application path
     *
     * @var App\Router
     */
	public root;

	/**
     * Zephir path
     *
     * @var string
     */
	public zephir;

	/**
     * Configuration path
     *
     * @var string
     */
	public config;

	/**
	 * Storage path
	 *
	 * @var string
	 */
	public storage;

	/**
     * Cache path
     *
     * @var App\Router
     */
	public cache;

    /**
     * Resource path
     *
     * @var string
     */
    public web;

    /**
     * Resource path
     *
     * @var string
     */
    public resources;

	/**
     * Config Instance
     *
     * @var App\Config
     */
	private static static_path;

	/**
     * Constructors
     *
     */
	private function __construct(server = null)
	{
        var user;

        if(empty(_SERVER["DOCUMENT_ROOT"]))
        {
            if(server == null)
            {
                let user = system("whoami");
            }
            else
            {
                let user = server;
            }
            let this->root = "/home/".user;
        }
        else
        {
            let this->root = realpath(_SERVER["DOCUMENT_ROOT"]."/../");
        }

		let this->zephir       = this->root . "/app";
		let this->config       = this->root . "/config";
		let this->cache        = this->root . "/tmp/cache";
		let this->storage      = this->root . "/tmp/storage";
        let this->web          = this->root . "/public";
        let this->resources    = this->root . "/public/res";
	}

	/**
     * Get path instance
     *
     * @return App\Config
     */
	public inline static function getInstance(server = null)
    {
        if (!self::static_path) {
            let self::static_path = new Path(server);
        }

        return self::static_path;
    }

	/**
     * Configuration files
     *
     * @param string file
     * @return string
     */
	public inline function config(string file = "") -> string
	{
		var config;
		let config = this->config;

		if (strlen(file) > 0)
		{
			let config = config . "/" . file . ".yaml";
		}

		return config;
	}

}