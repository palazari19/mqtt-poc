<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

use App\Jobs\SendFlags;

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('test', 'MqttController@connectaComTudo');

//$router->get('send', 'QueueController@sendToQueue');
$router->get('send', function () {
    $this->dispatch(new SendFlags('42953715568'));
    return 'true';
});
