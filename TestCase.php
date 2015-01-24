<?php
class TestCase extends \PHPUnit_Framework_TestCase
{

	public $development = true;

	public function dev()
	{
		return $this->development;
	}

    public function debug($variable)
    {
    	print_r($variable);
    	die();
    }
}