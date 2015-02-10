<?php
/*
 +--------------------------------------------------------------------------+
 | Penlook Project                                                          |
 +--------------------------------------------------------------------------+
 | Copyright (c) 2015 Penlook Development Team                              |
 +--------------------------------------------------------------------------+
 |                                                                          |
 | This program is free software: you can redistribute it and/or modify     |
 | it under the terms of the GNU Affero General Public License as           |
 | published by the Free Software Foundation, either version 3 of the       |
 | License, or (at your option) any later version.                          |
 |                                                                          |
 | This program is distributed in the hope that it will be useful, but      |
 | WITHOUT ANY WARRANTY; without even the implied warranty of               |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
 | GNU Affero General Public License for more details.                      |
 |                                                                          |
 | You should have received a copy of the GNU Affero General Public License |
 | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
 |                                                                          |
 +--------------------------------------------------------------------------+
 |   Authors: Loi Nguyen  <loint@penlook.com>                               |
 |            Viet Nguyen <vietna@penlook.com>                              |
 +--------------------------------------------------------------------------+
*/

namespace App;

/**
 * Loader Test
 *
 * @category   Penlook Application
 * @package    App
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class IndexTest extends Test
{
    /**
     * Test Application Flow
     */
    public function testApplicationFlow()
    {
        $app = new App();
        $app ->setRoot(__DIR__)
             ->setMode(App::DEBUG)
             ->setServices(function($services) use ($app) {
                foreach ($services as $name => $instance) {
                    $app->setService($name, function() use ($instance) {
                        return $instance;
                    });
                }
             });

        print_r($app);

        /*$closure = array(
            'url'              => \App\Service::getUrl(),
            'path'             => \App\Service::getPath(),
            'config'           => \App\Service::getConfig(),
            'router'           => \App\Service::getRouter(),
            'session'          => \App\Service::getSession(),
            'cookie'           => \App\Service::getCookie(),
            'crypt'            => \App\Service::getCrypt(),
            'storage'          => \App\Service::getStorage(),
            'redis'            => \App\Service::getRedis(),
            'view'             => \App\Service::getView(),
            'collectionManager'=> \App\Service::getCollectionManager()
        );

        $service = \App\Service::getInstance()->getService();

        foreach ($closure as $key => $value) {
            $service->set($key, function() use ($value) {
                return $value;
            });
        }

        $service->set('view', function() use ($closure, $service) {
            $view = $closure["view"];

            $view->registerEngines(array(
                '.volt' => function($view, $service) {
                    return \App\Service::getVolt($view, $service);
                }
            ));

            return $view;
        } , true);

        $service->set('mysql', function() {
            return \App\Service::getMysql();
        }, true);

        $service->set('mongo', function() {
            return \App\Service::getMongo();
        }, true);
        
        (new App())
            ->setRoot(__DIR__)
            ->setMode(App::DEBUG)
            ->setService($service)
            ->run();

        


        new App()
    ->setRoot(__DIR__ . "/public")
    ->setMode(App::Default)
    ->setPublic(false)
    ->setLanguage('en_US')
    ->setService()
    ->run();*/


    }

}
