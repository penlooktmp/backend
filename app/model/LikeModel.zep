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

use App\Model\Collection\Like;
use App\Model;

/**
 * Comment Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class LikeModel extends Model
{
    /**
     * SkillTable instance
     *
     * @var skill
     */
    private like;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string id
     */
    public inline function __construct(id = null, status_id = null)
    {
        parent::__construct();
        if  (!is_string(id) || ((strlen(id) < 20) && !is_null(id))) {
            return;
        }

        if (!is_null(id))
        {
            let this->like = Like::findById(id);
        }
        else
        {
            if (!is_null(status_id))
            {
                let this->like = Like::find([[
                    "data.parent_id" : status_id
                    ]
                ]);
            }
            else
            {
                let this->like = Like::find();
            }
        }
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public inline function getLike()
    {
        return this->like;
    }

    public inline function getLikeByStatusId(var id)
    {
        return Like::find([
            "status_id = '".id."'"
            ]);
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
        return is_object(this->like->{"_id"}) ? true : false;
    }

}