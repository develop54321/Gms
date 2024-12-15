<?php

namespace components;

use xPaw\SourceQuery\SourceQuery;

class GameServerQuery
{

    const SQ_TIMEOUT = 3;

    private $game_type;
    private $ip;
    private $port;
    private $query_port = null;

    private array $convertorGameType = [
        'cs' => 'cs16',
        'css' => 'css',
        'csgo' => 'csgo',
        'garrymod' => 'gmod',
        'samp' => 'samp',
        'arma' => 'arma',
        'rust' => 'rust',
        'tf2' => 'tf2',
        'l4d2' => 'l4d2',
        'unturned' => 'unturned',
        'kf2' => 'killingfloor2',
        'dayz' => 'dayz',
        'arkse' => 'arkse',
        'csgo2' => 'csgo',
        'minecraft' => 'minecraft',
        'gta5' => 'gta5m'
    ];


    /**
     * @param $value
     * @return string
     */
    public function getConvertorGameType($value): ?string
    {
        if (array_key_exists($value, $this->convertorGameType)) {
            return $this->convertorGameType[$value];
        }

        return null;

    }


    /**
     * GameServerQuery constructor.
     * @param string $ip
     * @param string $port
     * @param string $game_type
     * @param null $query_port
     */
    public function __construct(string $ip, string $port, string $game_type, $query_port = null)
    {
        $this->ip = $ip;
        $this->port = $port;
        $this->game_type = $game_type;
        $this->query_port = $query_port;
    }

    private function convertIp($value) {
        if(filter_var($value, FILTER_VALIDATE_IP)) {
            return $value;
        } else {
            return gethostbyname($value);
        }
    }
    /**
     * @return mixed|null
     * @throws \Exception
     */
    public function query(): mixed
    {
        $ip = $this->convertIp($this->ip);
        $convertorGameType = $this->getConvertorGameType($this->game_type);
        if ($convertorGameType === null){
            return null;
        }

        $address = $ip.":".$this->port;
        $queryParams = [
            'type' => $convertorGameType,
            'host' => $address
        ];



        if ($this->query_port !== null && $this->query_port != ""){
            $queryParams['options']['query_port'] = $this->query_port;
        }



        try {

            $GameQ = new \GameQ\GameQ();
            $GameQ->addServer($queryParams);
            $results = $GameQ->process();



            return $results[$address] ?? null;
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    /**
     * @return array|bool
     * @throws \Exception
     */
    public function players()    {
        $ip = $this->convertIp($this->ip);

        $address = $ip.":".$this->port;
        $queryParams = [
            'type' => $this->getConvertorGameType($this->game_type),
            'host' => $address,
        ];

        if ($this->query_port !== null && $this->query_port != ""){
            $queryParams['options']['query_port'] = $this->query_port;
        }
        try {

            $GameQ = new \GameQ\GameQ();
            $GameQ->addServer($queryParams);
            $results = $GameQ->process();


            return $results[$address]['players'] ?? null;
        } catch (\Exception $e) {
            throw new \Exception("Сервер не отвечает, попробуйте ещё раз");
        }
    }

    /**
     * @return array|bool
     * @throws \Exception
     */
    public function settings(){
        $Query = new SourceQuery();
        try {
            $Query->Connect($this->ip, $this->port, self::SQ_TIMEOUT, SourceQuery::SOURCE);
            return $Query->GetRules();
        } catch (\Exception $e) {
            throw new \Exception("Сервер не отвечает, попробуйте ещё раз");
        } finally {
            $Query->Disconnect();
        }

    }

}