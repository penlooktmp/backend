/**
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Tin Nguyen <tinntt@penlook.com>
 *
 */
namespace App\Model;

use App\Model\Table\Alias;
use App\Model;

/**
 * Alias Model
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
class AliasModel extends Model
{
    /**
     * AliasTable instance
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @var alias
     */
    private alias;

    /**
     * Constructor
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @param string $alias
     */
    public function __construct(string alias)
    {
        parent::__construct();
        let this->alias = Alias::findFirst([
            "name = '".alias."'"
        ]);
    }

    /**
     * Get Data from table object
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return table object
     */
    public function getAlias()
    {
        return this->alias;
    }
    /**
     * Is valid
     * This is check valid function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return bool
     */
    public function isValid()
    {
        return this->alias ? true : false;
    }

    /**
     * Get controller
     * This is get controller function
     *
     * @author Tin Nguyen <tinntt@penlook.com>
     * @return string
     */
    public function getController()
    {
        var controller;
        let controller = false;

        switch (this->alias->type) {
            case "u": let controller = "User";
                break;
            case "o": let controller = "Organization";
                break;
            case "s": let controller = "Skill";
                break;
        }

        return controller ? controller : false;
    }
}
