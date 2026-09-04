<?php

namespace components;

use core\Database;

/**
 * Read-only, request-cached access to ga_settings.content, for places (templates,
 * widgets) that need a setting but aren't handed $settings by their controller.
 */
class Settings
{
    private static ?array $cache = null;

    public static function all(): array
    {
        if (self::$cache === null) {
            $db = new Database();
            $row = $db->query('SELECT content FROM ga_settings LIMIT 1')->fetch();
            self::$cache = $row ? (json_decode($row['content'], true) ?: []) : [];
        }

        return self::$cache;
    }

    public static function global(string $key, $default = null)
    {
        $settings = self::all();
        return $settings['global_settings'][$key] ?? $default;
    }
}
