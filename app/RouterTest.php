<?php
/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *      Viet Nguyen <vietna@penlook.com>
 *
 */

namespace App;

use App\Router;

/**
 * Router Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class RouterTest extends Test
{
    protected $router;

    public function __construct()
    {
        $this->router = Router::getInstance();
    }

    public function testGetInstance()
    {
        $input = $this->router;
        $expect = $this->router;
        $output = Router::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testConfigureRouter()
    {
        // $input = "testConfigureRouter";
        // $expect = "/home/vietna/config/config.yaml";
        // $output = $this->router->configureRouter();
        // $this->assertEquals($output, $expect);
    }

    public function testGetRouter()
    {
        // Unknown
    }
}
