<?php


namespace App\Http\Controllers;

//use Mosquitto\Client;
use Salman\Mqtt\MqttClass\Mqtt;

class MqttController
{

    public function connectaComTudo()
    {
        $mq = new Mqtt();
        $output = $mq->ConnectAndPublish("canal/teste", "flag eh true");
        if ($output === true)
        {
            return "published";
        }

        return "Failed";
    }
}
