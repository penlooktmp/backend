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
namespace App;

use Phalcon\Mvc\Model as Phalcon_Model;

/**
 * Application Test
 *
 * @category   PenlookTest
 * @package    App
 * @author     Loi Nguyen <loint@penlook.com>
 * @copyright  Penlook Development Team
 * @license    Commercial
 * @version    1.0
 * @link       http://penlook.com
 * @since      Class available since Release 1.0
 */
class Test extends \PHPUnit_Framework_TestCase
{
	public development = true;

	public function dev()
	{
		return this->development;
	}

    public function debug(variable)
    {
    	print_r($variable);
    	die();
    }
}