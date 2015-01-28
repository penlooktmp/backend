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

use App\Loader;

/**
 * Loader Test
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
class LoaderTest extends Test
{
    protected $loader;

    public function __construct() {
        $this->loader = Loader::getInstance();
    }

    public function testGetInstance(){
        $input = $this->loader;
        $expect = $this->loader;
        $output = Loader::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testGetNamespaces(){
        $input = $this->loader;
        $expect = array();
        $output = $this->loader->getNamespaces();
        $this->assertEquals($output, $expect);
    }

    public function testRegisterNamespaces(){
        $input = $this->loader;
        $expect = NULL;
        $output = $this->loader->registerNamespaces();
        $this->assertEquals($output, $expect);
    }

    public function testGetLoader(){
        //Unknown
    }

}
