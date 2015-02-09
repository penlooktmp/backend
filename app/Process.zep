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

namespace App;

/**
 * Process
 *
 * @category   Penlook Application
 * @package    App\System
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Process
{

    private static static_process;

    /**
     * Return Process Instant
     *
     * @return Process
     */
    public inline static function getInstance()
    {
        if (!self::static_process) {
            let self::static_process = new Process();
        }

        return self::static_process;
    }

    /**
     * Convert array to object
     *
     * @param arr
     *
     * @return mixed
     */
    public inline static function arr2obj(var arr)
    {
        return json_decode(json_encode(arr), false);
    }

    /**
     * Debug variable
     *
     * @param variable
     */
    public inline static function debug(var variable)
    {
        echo "<pre>";
        print_r(variable);
        echo "</pre>";
        die();
    }

    /**
     * Encode password
     *
     * @param email
     * @param hash_password
     *
     * @return string
     */
    public inline static function encodePassword(var email, var hash_password) // Encode second times
    {
        // $secure = '~!@#$%^&*()_+[]';
        // $hash_password = md5(sha1(password).$secure));
        var salt;
        let salt = "D6Aa45zzTyOPA12309Pso981266";

        return md5(sha1(hash_password . salt) . email); // unique
    }

    /**
     * Get extension of file name
     * @param  string path
     * @return string
     */
    public inline static function getExtension(path)
    {
        return substr(strrchr(path,'.'),1);
    }

    /**
     * Get extension of file name
     * @param  string path
     * @return string
     */
    public inline static function getFileType(path)
    {
        var ext;
        let ext = self::getExtension(path);

        switch (ext) {
            case "less":
                return "less";
            case "coffee":
                return "coffeescript";
            case "css":
                return "css";
            case "js":
                return "javascript";
            default:
                return "text";
        }
    }

    /**
     * MD5 Encoding
     *
     * @param text
     * @param limit
     *
     * @return hash
     */
    public inline static function md5(text, limit=null)
    {
        if is_null(limit) {
            return md5(text);
        } else {
            var res;
            let res = md5(text);
            return substr(res, 0, limit);
        }
    }

    /**
     * Matching pattern
     *
     * @param text
     * @param limit
     *
     * @return hash
     */
    public inline static function match(pattern, text)
    {
        var matches;
        let matches = [];
        preg_match(pattern, text, matches);
        return (count(matches)>0) ? true : false;
    }

    /*public static function hashID(var id)
    {
        var hash_number, hash_table, str_hash, hash = "", k, ch;

        let hash_number = 1050382 + id;
        let hash_table = "APZPLMXYDW";
        let str_hash = strval(hash_number);
        for ch in str_hash
        {
            let k = intval(ch);
            let hash .= hash_table[k];
        }

        return hash;
    }*/

    public inline static function cropImage(var source_image, var target_image, var crop_area)
    {
        var source_file_name, source_image_type, original_image, cropped_image;

        let source_file_name = basename(source_image);
        let source_image_type = substr(source_file_name, -3, 3);

        switch (strtolower(source_image_type)) {
            case "jpg":
                let original_image = imagecreatefromjpeg(source_image);
                break;

            case "gif":
                let original_image = imagecreatefromgif(source_image);
                break;

            case "png":
                let original_image = imagecreatefrompng(source_image);
                break;

            default:
                trigger_error("cropImage(): Invalid source image type", E_USER_ERROR);

                return false;
        }

        let cropped_image = imagecreatetruecolor(crop_area["width"], crop_area["height"]);
        imagecopy(cropped_image, original_image, 0, 0, crop_area["left"], crop_area["top"], crop_area["width"], crop_area["height"]);
        var target_file_name, target_image_type;

        let target_file_name = basename(target_image);
        let target_image_type = substr(target_file_name, -3, 3);

        switch (strtolower(target_image_type)) {
            case "jpg":
                imagejpeg(cropped_image, target_image, 100);
                break;

            case "gif":
                imagegif(cropped_image, target_image);
                break;

            case "png":
                imagepng(cropped_image, target_image, 0);
                break;

            default:
                trigger_error("cropImage(): Invalid target image type", E_USER_ERROR);
                imagedestroy(cropped_image);
                imagedestroy(original_image);

                return false;
        }
        imagedestroy(cropped_image);
        imagedestroy(original_image);

        return true;
    }

    public function splitWord(var str)
    {
        return explode(str, " ");
    }

}