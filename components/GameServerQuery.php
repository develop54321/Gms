<?php

namespace components;

use xPaw\SourceQuery\SourceQuery;
use GameQ\GameQ;

class GameServerQuery
{
    const SQ_TIMEOUT = 3;

    private string $ip;
    private int $port;
    private string $gameType;
    private ?int $queryPort;

    private array $convertorGameType = [
        'cs'        => 'cs16',
        'css'       => 'css',
        'csgo'      => 'csgo',
        'csgo2'     => 'csgo',
        'garrymod'  => 'gmod',
        'tf2'       => 'tf2',
        'l4d2'      => 'l4d2',
        'samp'      => 'samp',
        'minecraft' => 'minecraft',
        'rust'      => 'rust',
        'dayz'      => 'dayz',
        'arkse'     => 'arkse',
        'mta'       => 'mta',
        'gta5'      => 'gta5m',
    ];

    public function __construct(string $ip, int $port, string $gameType, ?int $queryPort = null)
    {
        $this->ip        = $this->resolveIp($ip);
        $this->port      = $port;
        $this->gameType  = $gameType;
        $this->queryPort = $queryPort;
    }

    private function resolveIp(string $value): string
    {
        return filter_var($value, FILTER_VALIDATE_IP)
            ? $value
            : gethostbyname($value);
    }

    private function getGameType(): string
    {
        if (!isset($this->convertorGameType[$this->gameType])) {
            throw new \Exception('Неизвестный тип игры');
        }
        return $this->convertorGameType[$this->gameType];
    }

    /**
     * Главный метод
     */
    public function query(): array
    {
        $type = $this->getGameType();

        return $type === 'cs16'
            ? $this->queryCs16()
            : $this->queryGameQ($type);
    }

    /**
     * CS 1.6 через SourceQuery
     */
    private function queryCs16(): array
    {
        $Query = new SourceQuery();

        try {
            $Query->Connect($this->ip, $this->port, self::SQ_TIMEOUT, SourceQuery::GOLDSOURCE);

            $info = $Query->GetInfo();

            return [
                'hostname'    => $info['HostName'] ?? null,
                'map'         => $info['Map'] ?? null,
                'players'     => (int)($info['Players'] ?? 0),
                'max_players' => (int)($info['MaxPlayers'] ?? 0),
                'raw'         => $info,
            ];

        } catch (\Exception $e) {
            throw new \Exception('CS 1.6 сервер не отвечает');
        } finally {
            $Query->Disconnect();
        }
    }

    /**
     * Все остальные игры через GameQ
     */
    private function queryGameQ(string $type): array
    {
        $GameQ = new GameQ();

        $params = [
            'type' => $type,
            'host' => "{$this->ip}:{$this->port}",
        ];

        if ($this->queryPort) {
            $params['options']['query_port'] = $this->queryPort;
        }

        try {
            $GameQ->addServer($params);
            $results = $GameQ->process();

            $data = reset($results);

            if (!$data || empty($data['gq_online'])) {
                throw new \Exception();
            }

            return [
                'hostname'    => $data['gq_hostname'] ?? null,
                'map'         => $data['gq_mapname'] ?? null,
                'players'     => (int)($data['gq_numplayers'] ?? 0),
                'max_players' => (int)($data['gq_maxplayers'] ?? 0),
                'raw'         => $data,
            ];

        } catch (\Exception $e) {
            throw new \Exception('Сервер не отвечает или недоступен');
        }
    }
}
