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
namespace App\Model;

use App\Model\Table\Language;
use App\Model;

/**
 * Language Model
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
    public inline function __construct(id = null)
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
    public inline function getData()
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
    public inline function isValid()
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
    public inline function getAllLanguages()
    {
        return Language::find()->toArray();
    }
}