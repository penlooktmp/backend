/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Loi Nguyen <loi@penlook.com>
 *
 */
namespace App\Service;

/**
 * Global SMS Gateway
 *
 * @category   Penlook Application
 * @package    App\Service
 * @author     Loi Nguyen <loi@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Sms
{
    const SMSGATEWAY = "";
    const SMSTOKEN = "";

    public sms;

    public inline function create(recipient, message)
    {
        var xmlsms;

        let xmlsms = "<MESSAGES><AUTHENTICATION><PRODUCTTOKEN>". Sms::SMSTOKEN ."</PRODUCTTOKEN></AUTHENTICATION>";
        let xmlsms = xmlsms . "<MSG><FROM>". Sms::SMSTOKEN ."</FROM><TO>". recipient ."</TO><BODY>". message ."</BODY><REFERENCE></REFERENCE></MSG></MESSAGES>";

        let this->sms = xmlsms;
        return this;
    }

    public inline function send()
    {
        var cmd;
        let cmd = "curl -i " . Sms::SMSGATEWAY . " -X POST -H 'Content-type: application/xml' -d '";
        let cmd = cmd . this->sms . "'";
        system(cmd);

        return "OK";
    }
}
