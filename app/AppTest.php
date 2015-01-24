<?php
/*
 * Copyright (C) 2014 Penlook
 *                    Vietnam
 *                    http://www.penlook.com
 *                    support@penlook.com
 *
 * Authors:
 *  Loi Nguyen <loint@penlook.com>
 *
 */

require_once __DIR__ . '/../TestCase.php';

use App\App;

/**
 * App Test
 *
 * @category   Penlook Application
 * @package    App
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class AppTest extends TestCase
{
    public function testSample() {
        $app = App::getInstance();
        $output = 'Hello';
        $expect = 'Hello';
        $this->assertEquals($output, $expect);
    }
}
