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
 * App Configuration
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
class App
{
    /**
     * App Instance
     */
    private static static_app;

    /**
     * Session storage
     */
    private session;

    /**
     * During run time
     */
    private during;

    /**
     * Debug mode
     */
    public debug;

    /**
     * Constructor
     *
     */
    private function __construct()
	{
        let this->session = Service::getSession();
	}

    /**
     * Get an instance
     *
     * @return App\Config
     */
	public inline static function getInstance()
    {
        if (!self::static_app) {
            let self::static_app = new App();
        }

        return self::static_app;
    }

    public inline function start()
    {

    }

    public inline function end()
    {

    }

    public inline function setMode(production = false)
    {
        let this->debug = false;

        if ! production {
            error_reporting(E_ALL);
            ini_set("display_errors", 1);
            let this->debug = true;
        }
    }

    public inline function get(name)
    {
        var str;
        let str = this->session->get(name);

        if is_null(str) {
            var redis;
            let redis = Service::getRedis();
            let str = redis->get(name);

            if str {
                this->session->set(name, str);
            }
        }

        return str ? igbinary_unserialize(str) : false;
    }

    public inline function set(name, service)
    {
        var str, redis;
        let str = igbinary_serialize(service);
        let redis = Service::getRedis();
        redis->set(name, str);
        this->session->set(name, str);
    }
}