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

use App\Path;

/**
 * Path Test
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
class PathTest extends Test
{
    protected $path;

    public function __construct() {
        $this->path = Path::getInstance();
    }

    public function testGetInstance(){
        $input = $this->path;
        $expect = $this->path;
        $output = Path::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testConfig(){
        $input = "config";
        $expect = "/home/vietna/config/config.yaml";
        $output = $this->path->config($input);
        $this->assertEquals($output, $expect);
    }
}
