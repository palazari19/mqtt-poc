<?php

namespace App\Jobs;

use App\Services\FlagsService;
use Illuminate\Support\Facades\Log;
use Salman\Mqtt\MqttClass\Mqtt;

class SendFlags extends Job
{
    private $payload;
    private $flagsService;
    private $cpf;
    private $mqtt;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($cpf)
    {
        $this->cpf = $cpf;
    }

    private function boot()
    {
        $this->flagsService = new FlagsService();
        $this->mqtt = new Mqtt();
        $this->flagsService->boot();
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $this->boot();
        $this->flagsService->setCPF($this->cpf);
        $this->payload = $this->flagsService->getFlagsForUser();
        $topic = "picpay/" . $this->payload->channel . '/' . $this->payload->child;
        $this->mqtt->ConnectAndPublish($topic, json_encode($this->payload));
    }
}
