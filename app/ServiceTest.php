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

use App\Storage;

/**
 * Storage Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class StorageTest extends Test
{
    private $storage;

    public function __construct()
    {
        $this->storage = Storage::getInstance();
    }

    public function testGetInstance()
    {
        $input = $this->storage;
        $expect = $this->storage;
        $output = Storage::getInstance();
        $this->assertEquals($output, $expect);
    }

    public function testGetStorage()
    {
        $input = $this->storage;
        $expect = NULL;
        $output = $this->storage->getStorage();
        $this->assertEquals($output, $expect);
    }
}
