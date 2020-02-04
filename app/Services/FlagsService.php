<?php


namespace App\Services;


class FlagsService
{

    private $cpf;
    private $obj;

    public function setCPF($cpf): void
    {
        $this->cpf = $cpf;
    }

    public function boot(): void
    {
        $file = file_get_contents(storage_path('files/flags.json'));
        $this->obj = json_decode($file);
    }

    public function getFlagsForUser()
    {
        foreach ($this->obj as $key => $data) {
            if($key == $this->cpf) {
                return $data;
            }
        }

        return false;
    }

}
