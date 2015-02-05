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

/**
 * Application Router
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
class Storage
{

    /**
     * Google Storage
     *
     * @var App\Storage
     */
	public storage;

    /**
     * Cloud storage static instance
     *
     * @var App\Storage
     */
	private static static_storage;

    /**
     * Constructor
     *
     */
    private inline function __construct()
	{

	}

    /**
     * Get router instance
     *
     * @return App\Storage
     */
	public inline static function getInstance()
    {
        if (!self::static_storage) {
            let self::static_storage = new Storage();
        }

        return self::static_storage;
    }

    /**
     * Get storage
     *
     * @return App\Storage
     */
    public inline function getStorage()
    {
    	return this->storage;
    }

}