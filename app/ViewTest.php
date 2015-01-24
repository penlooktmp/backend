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

require_once __DIR__ . '/../TestCase.php';

use App\View;

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
class ViewTest extends TestCase
{
    private $view;

    public function __construct() {
        $this->view = new View();
    }

    public function testTranslate(){
        $_SESSION['language'] = 'vi_VN';

        $input = 'Software Development';
        $expect = 'Software Development';

        $output = $this->view->trans($input);
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
