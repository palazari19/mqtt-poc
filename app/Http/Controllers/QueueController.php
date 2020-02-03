<?php

namespace App\Http\Controllers;

use App\Jobs\SendFlags;
use App\Services\FlagsService;
use Illuminate\Queue\Queue;

class QueueController extends Controller
{

    private $flagsService;

    public function __construct(FlagsService $flagsService)
    {
        $this->flagsService = $flagsService;
        $this->flagsService->boot();
    }

    public function sendToQueue()
    {
        try{
            $this->flagsService->setCPF('42953715568');
            $this->flagsService->getFlagsForUser();
            $this->dispatch(new SendFlags());
//            Queue::push(new SendFlags());
//        Queue::push(new ExampleJob);
        }catch (\Exception $e) {
            dd($e->getMessage());
        }

    }
}
