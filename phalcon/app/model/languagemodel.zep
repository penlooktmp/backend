/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

namespace Phalcon\App\Model;

use Phalcon\App\Model\Table\Language;
use Phalcon\App\Model;

/**
 * Language Model
 *
 * @category   Penlook Application
 * @package    App\Model
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class LanguageModel extends Model
{
    /**
     * LanguageTable instance
     *
     * @var AppModel
     */
     private language;
    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $id
     */
    public function __construct(id = null)
    {
        var field;
        parent::__construct();
        if (is_null(id))
        {
            return;
        }

        let field = is_numeric(id) ? "id" : "alias";

        let this->language = Language::findFirst([
            field." = '".id."'"
        ]);

        /*if ($language) {
            $this->add($language);
        }*/
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public function getData()
    {
        return this->language;
    }
    /**
     * Is Valid
     * This is check valid function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public function isValid()
    {
        return is_object(this->language) ? true : false;
    }

    /**
     * Get All Languages
     * This is get all languages function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return Array Object
     */
    public function getAllLanguages()
    {
        //return Language::find()->toArray();
    }
}