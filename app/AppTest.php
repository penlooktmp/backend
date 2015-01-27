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

/**
 * App Test
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
class AppTest extends Test
{
    private $app;

    public function __construct() {
        $this->app = App::getInstance();
    }

    public function testGetInstance(){
        $input = $this->app;
        $expect = $this->app;

        $output = App::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testStart(){
        // unknown
    }

    public function testSetMode(){
        // unknown
    }

    public function testGet(){
        // unknown
    }

    public function testSet(){
        // unknown
    }
}
