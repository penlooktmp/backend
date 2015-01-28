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

use App\View;

/**
 * View Test
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
class ViewTest extends Test
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

    public function testSite(){
        $_SERVER['SERVER_NAME'] = 'penlook.com';

        $input = 'abc';
        $expect = 'http://penlook.com/abc';
        $output = $this->view->site($input);
        $this->assertEquals($output, $expect);
    }

    public function testJson(){
        $input = new \stdClass();
        $input->test1 = "test1";
        $input->test2 = "test2";

        $expect =  '<script>var json = {"test1":"test1","test2":"test2"};</script>';
        $output = $this->view->json($input);
        $this->assertNotNull($output);
        $this->assertEquals($output, $expect);
    }

    public function testImg()
    {
        $input = "testImg.png";
        $expect = 'http:///img/testImg.png';
        $output = $this->view->img($input);
        $this->assertEquals($output, $expect);
    }

    public function testCss(){
        $input = "test";

        $expect = '<link rel="stylesheet" type="text/css" href="test.css" />';

        $output = $this->view->css($input);
        $this->assertEquals($output, $expect);
    }

    public function testJs()
    {
        $input = "test";
        $expect = "<script>(function(){function e(){var e=document.createElement('script');e.type='text/javascript';e.async=true;e.src='test.js';var t=document.getElementsByTagName('script')[0];t.parentNode.insertBefore(e,t)}if(window.attachEvent){window.attachEvent('onload',e);}else {window.addEventListener('load',e,false)}})()</script>";

        $output = $this->view->js($input);
        $this->assertEquals($output, $expect);
    }

    public function testLess()
    {
        // Unknown
    }

    public function testcoffee()
    {
        // Unknown
    }
}
