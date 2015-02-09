<?php
namespace App;

(new App())
   	->setRoot(__DIR__)
   	->setMode(App::Debug)
    ->run();

/*
new App()
	->setRoot(__DIR__ . "/public")
   	->setMode(App::Default)
   	->setPublic(false)
   	->setLanguage('en_US')
   	->setService()
   	->run();
*/