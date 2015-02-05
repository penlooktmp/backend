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

use App\Process;

/**
 * Process Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class ProcessTest extends Test
{
    protected $process;

    public function __construct()
    {
        $this->process = Process::getInstance();
    }

    public function testGetInstance()
    {
        $input = $this->process;
        $expect = $this->process;
        $output = Process::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testArr2obj()
    {
        // $input = array("test" => "test");
        // $expect = unknown;
        // $output = $this->process->arr2obj($input);
        // $this->assertEquals($output, $expect);
    }

    public function testEncodePassword()
    {
        // Unknown
    }

}
