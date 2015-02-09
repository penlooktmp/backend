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
