<?php
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

namespace App;

use App\Model;

/**
 * Model Test
 *
 * @category   Penlook Application
 * @package    App
 * @author     Viet Nguyen <vietna@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class ModelTest extends Test
{
    protected $model;

    public function __construct()
    {
        $this->model = new Model();
    }

    public function testSession()
    {
        //Unknown
    }

    public function testIntegrate()
    {
        //Not yet handled
    }

}
