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

/**
 * Application Compiler
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

class Tidy
{
    public inline static function compress(php)
    {
        var compressed, pattern, replace;
        let compressed = php;

        let pattern = "/[\\s]{2,}/";
        let replace = " ";
        let compressed = preg_replace(pattern, replace, compressed);

        let pattern = "/>[\\n\\r\\s]+</";
        let replace = "><";
        let compressed = preg_replace(pattern, replace, compressed);

        return compressed;
    }
}