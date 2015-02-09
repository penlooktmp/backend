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

namespace App\Plugin;

/**
 * App Analyser
 *
 * @category   Penlook Application
 * @package    App\App
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Analyser
{
    public static function analys()
    {
        //var session, redis, css_name, js_name;
        var session, redis, css_name, js_name;
        let session = \App\Service::getSession();
        let redis = \App\Service::getRedis();

        let css_name = session->get("css");
        let js_name  = session->get("js");

        //let html = this->analysDOM(html);
        //let css = this->analysCSS(redis->get(css_name));
        self::analysCSS(redis->get(css_name));
        die();

        //print_r(this->analysCSS(html));
    }

    public static function analysDOM(html)
    {
        var html_start, html_end;

        let html_start = (int) strpos(html, "<html>");
        let html_end   = (int) strpos(html,"</html>");
        let html_start += 6;
        let html = substr(html, html_start, html_end - html_start);

        var class_pattern, id_pattern, tag_pattern, property_pattern;

        // Pattern
        let class_pattern    = "/class=\"[A-Za-z0-9-\\s_]+\"/";
        let id_pattern       = "/id=\"[A-Za-z0-9-\\s_]+\"/";
        let tag_pattern      = "/<[A-za-z0-9]+/";
        let property_pattern = "/(class|\"|=|<|id)/";

        var res_class, res_id, res_tag;
        let res_class = [];
        let res_id    = [];
        let res_tag   = [];

        preg_match_all(class_pattern, html, res_class, PREG_OFFSET_CAPTURE);
        preg_match_all(id_pattern, html, res_id, PREG_OFFSET_CAPTURE);
        preg_match_all(tag_pattern, html, res_tag, PREG_OFFSET_CAPTURE);

        var class_block, class_blocks, id_block, id_blocks, tag_block, tag_blocks;

        let class_blocks = [];
        let id_blocks    = [];
        let tag_blocks   = [];


        for class_block in res_class[0] {
            let class_blocks[] = preg_replace(property_pattern, "", class_block[0]);
        }

        for id_block in res_id[0] {
            let id_blocks[] = preg_replace(property_pattern, "", id_block[0]);
        }

        for tag_block in res_tag[0] {
            let tag_blocks[] = preg_replace(property_pattern, "", tag_block[0]);
        }

        // Parse and unique class
        var value, _class, _id, _tag, dom;

        let _class = [];
        let _id    = [];
        let _tag   = [];

        for _, value in class_blocks {
            let _class = array_merge(_class, explode(" ", value));
        }

        for _, value in id_blocks {
            let _id = array_merge(_id, explode(" ", value));
        }

        for _, value in tag_blocks {
            let _tag = array_merge(_tag, explode(" ", value));
        }

        let _class = array_unique(_class);
        let _id    = array_unique(_id);
        let _tag   = array_unique(_tag);

        let dom = [
            "id"    : _id,
            "class" : _class,
            "tag"   : _tag
        ];

        return dom;
    }

    public static function parseBlock(css)
    {
        var selector = "", phrase = [], ch, str;
        int top = 0;
        let str = str_split(css);

        for ch in str {
            let selector .= ch;
            if ch == "{" {
                let top += 1;
            } else {
                if ch == "}" {
                    let top -= 1;
                    if top == 0 {
                        let phrase []= self::parseBlock(selector);
                        break;
                    }
                }
            }
        }

        return phrase;
    }

    public static function analysCSS(css)
    {
        var phrase;
        let phrase = self::parseBlock(css);

        print_r(phrase);

        /*var i;
        for i in css {
            echo i;
            break;
        }*/
        die();

        /*
        var css_content, css_array, comment_pattern, block_pattern;

        let css_array = [];
        let comment_pattern = "/\\/*[A-Za-z0-9\\s,\'\"*-@!.|\\/]+\\*\\//";
        let block_pattern   = "/{[A-Za-z0-9-:;%!.\\s\'\",\\-+?#()_\\\\]+}/";

        let css_content = preg_replace(comment_pattern, "", css);
        preg_match_all(block_pattern, css_content, css_array, PREG_OFFSET_CAPTURE);

        let css = css_content;

        var block, blocks;
        let blocks = css_array[0];

        var num, start, i, index, selector, selectors;

        let selectors = [];
        let start = 0;
        let num = (int) count(blocks) - 1;

        for i in range(0, num) {

            let block = blocks[i][0];
            let index = (int) blocks[i][1];

            let selector = substr(css, start, index - start);
            let start = index + (int) strlen(block);

            let selectors[] = [
                "key"   : trim(selector),
                "value" : trim(block)
            ];

        }

        echo "<pre>";
        print_r(selectors);
        echo "</pre>";
        die();
        */
    }
}