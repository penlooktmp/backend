/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Viet Nguyen <vietna@penlook.com>
 *
 */
namespace App\Plugin\ReCaptcha;

/**
 * App Analyser
 *
 * @category   Penlook Application
 * @package    App\Plugin\ReCaptcha
 * @author     Viet Nguyen <vietna@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class ReCaptcha
{
	private static _signupUrl = "https://www.google.com/recaptcha/admin";
	private static _siteVerifyUrl = "https://www.google.com/recaptcha/api/siteverify?";
    public _secret;
    private static _version = "php_1.0";

    /**
     * Constructor.
     *
     * @param string $secret shared secret between site and ReCAPTCHA server.
     */
    public function __construct(secret)
    {
        if (secret == null || secret == "") {
            die("To use reCAPTCHA you must get an API key from <a href='"
                . self::_signupUrl . "'>" . self::_signupUrl . "</a>");
        }

        let this->_secret = secret;
    }

    /**
     * Encodes the given data into a query string format.
     *
     * @param array $data array of string elements to be encoded.
     *
     * @return string - encoded request.
     */
    private function _encodeQS(data)
    {
        string req = "";
        for key, value in data{
            let req .= key . "=" . urlencode(stripslashes(value)) . "&";
        }

        // Cut the last '&'
        let temp = strlen(req) - 1;
        let req = substr(req, 0, temp);
        return req;
    }

    // private function _submitHTTPGet(path, data)
    // {
    //     req = this->_encodeQS(data);
    //     response = file_get_contents(path . req);
    //     return response;
    // }

    // public function verifyResponse($remoteIp, $response)
    // {
    //     // Discard empty solution submissions
    //     if (response == null || strlen(response) == 0) {
    //         recaptchaResponse = new ReCaptchaResponse();
    //         recaptchaResponse->success = false;
    //         recaptchaResponse->errorCodes = 'missing-input';
    //         return recaptchaResponse;
    //     }

    //     getResponse = this->_submitHttpGet(
    //         self::_siteVerifyUrl,
    //         array (
    //             'secret' => this->_secret,
    //             'remoteip' => remoteIp,
    //             'v' => self::_version,
    //             'response' => response
    //         )
    //     );
    //     answers = json_decode(getResponse, true);
    //     recaptchaResponse = new ReCaptchaResponse();

    //     if (trim(answers ['success']) == true) {
    //         recaptchaResponse->success = true;
    //     } else {
    //         recaptchaResponse->success = false;
    //         recaptchaResponse->errorCodes = answers [error-codes];
    //     }

    //     return recaptchaResponse;
    // }
}

