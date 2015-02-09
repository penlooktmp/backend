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

namespace App\Model;

use App\Model\Collection\Topic;
use App\Model;

/**
 * Skill Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @author     Tin Nguyen <tinntt@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class TopicModel extends Model
{
    /**
     * SkillTable instance
     *
     * @var skill
     */
    private topic;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string id
     */
    public inline function __construct(id = null, des_id = null)
    {
        parent::__construct();
        if  (!is_string(id) || ((strlen(id) < 20) && !is_null(id))) {
            return;
        }

        if (!is_null(id))
        {
            let this->topic = Topic::findById(id);
        }
        else{
            if (des_id != "")
            {
                let this->topic = Topic::find([[
                    "data.des_id" : des_id
                    ]
                ]);
            }
            else
            {
                let this->topic = Topic::find();
            }
        }
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getTopic()
    {
        return this->topic;
    }

    /**
     * Is Valid
     * This is check valid id function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public inline function isValid()
    {
        return is_object(this->topic->{"_id"}) ? true : false;
    }

}