<?php

namespace components;

class ServerBanner
{
    public const VARIANTS = [
        'mini' => ['label' => 'Мини-кнопка', 'width' => 88, 'height' => 31, 'orientation' => 'horizontal'],
        'compact' => ['label' => 'Компактный', 'width' => 234, 'height' => 60, 'orientation' => 'horizontal'],
        'classic' => ['label' => 'Классический', 'width' => 468, 'height' => 60, 'orientation' => 'horizontal'],
        'leaderboard' => ['label' => 'Лидерборд', 'width' => 728, 'height' => 90, 'orientation' => 'horizontal'],
        'card' => ['label' => 'Карточка', 'width' => 300, 'height' => 250, 'orientation' => 'vertical'],
        'skyscraper' => ['label' => 'Скайскрепер', 'width' => 160, 'height' => 600, 'orientation' => 'vertical'],
    ];

    private const DEFAULT_VARIANT = 'classic';

    private const GAME_ICONS = [
        'cs' => 'cs.png',
        'csgo' => 'csgo.png',
        'css' => 'css.png',
        'tf2' => 'tf2.png',
        'ld2' => 'ld2.png',
        'rust' => 'rust.png',
        'samp' => 'samp.jpg',
        'mta' => 'mta.png',
        'csgo2' => 'csgo2.png',
        'arma_3' => 'arma3.png',
    ];

    private const FONT_BOLD = ROOT_DIR . 'public/fonts/Helvetica-bold.otf';
    private const FONT_REGULAR = ROOT_DIR . 'public/fonts/Helvitica.otf';

    public static function render(array $server, string $variant = self::DEFAULT_VARIANT): void
    {
        if (!isset(self::VARIANTS[$variant])) {
            $variant = self::DEFAULT_VARIANT;
        }

        switch ($variant) {
            case 'mini':
                self::renderMini($server);
                break;
            case 'compact':
                self::renderCompact($server);
                break;
            case 'leaderboard':
                self::renderLeaderboard($server);
                break;
            case 'card':
                self::renderCard($server);
                break;
            case 'skyscraper':
                self::renderSkyscraper($server);
                break;
            default:
                self::renderClassic($server);
        }
    }

    public static function renderNotFound(string $variant = self::DEFAULT_VARIANT): void
    {
        [$width, $height] = self::dimensions($variant);

        $image = imagecreatetruecolor($width, $height);
        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $gray = imagecolorallocate($image, 150, 155, 165);
        $fontSize = $width >= 234 ? 12 : 8;
        $text = $width >= 150 ? 'Сервер не найден' : 'N/A';

        self::drawCenteredText($image, $fontSize, self::FONT_BOLD, $gray, $text, $width, (int)($height / 2) + $fontSize / 2);

        self::output($image, false);
    }

    private static function renderMini(array $server): void
    {
        [$width, $height] = self::dimensions('mini');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, 3, $height, $accent);

        self::drawGameIcon($image, $server['game'] ?? '', 7, 4, 22, 22);

        $text = $isOnline ? $server['players'] . '/' . $server['max_players'] : 'OFF';
        imagettftext($image, 10, 0, 34, 20, $accent, self::FONT_BOLD, $text);

        self::output($image);
    }

    private static function renderCompact(array $server): void
    {
        [$width, $height] = self::dimensions('compact');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, 3, $height, $accent);

        $white = imagecolorallocate($image, 255, 255, 255);
        $gray = imagecolorallocate($image, 150, 155, 165);

        self::drawGameIcon($image, $server['game'] ?? '', 10, 10, 40, 40);

        $textX = 58;
        $hostname = self::truncate(strip_tags($server['hostname'] ?? ''), 20);
        imagettftext($image, 11, 0, $textX, 20, $white, self::FONT_BOLD, $hostname);

        $address = ($server['host'] ?: $server['ip']) . ':' . $server['port'];
        imagettftext($image, 8, 0, $textX, 33, $gray, self::FONT_REGULAR, $address);

        $statusText = $isOnline ? 'Онлайн' : 'Офлайн';
        imagettftext($image, 8, 0, $textX, 46, $accent, self::FONT_REGULAR, $statusText);

        $playersText = $isOnline ? $server['players'] . '/' . $server['max_players'] : '—';
        $bbox = imagettfbbox(14, 0, self::FONT_BOLD, $playersText);
        $textWidth = abs($bbox[4] - $bbox[0]);
        imagettftext($image, 14, 0, $width - 12 - $textWidth, 36, $accent, self::FONT_BOLD, $playersText);

        self::output($image);
    }

    private static function renderClassic(array $server): void
    {
        [$width, $height] = self::dimensions('classic');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, 4, $height, $accent);

        $white = imagecolorallocate($image, 255, 255, 255);
        $gray = imagecolorallocate($image, 150, 155, 165);

        self::drawGameIcon($image, $server['game'] ?? '', 16, 9, 42, 42);

        $textX = 68;

        $hostname = self::truncate(strip_tags($server['hostname'] ?? ''), 38);
        imagettftext($image, 12, 0, $textX, 20, $white, self::FONT_BOLD, $hostname);

        $address = ($server['host'] ?: $server['ip']) . ':' . $server['port'];
        imagettftext($image, 9, 0, $textX, 35, $gray, self::FONT_REGULAR, $address);

        $map = 'Карта: ' . self::truncate($server['map'] ?? '-', 28);
        imagettftext($image, 9, 0, $textX, 50, $gray, self::FONT_REGULAR, $map);

        $playersText = $isOnline ? $server['players'] . ' / ' . $server['max_players'] : 'OFFLINE';
        $bbox = imagettfbbox(16, 0, self::FONT_BOLD, $playersText);
        $textWidth = abs($bbox[4] - $bbox[0]);
        imagettftext($image, 16, 0, $width - 18 - $textWidth, 32, $accent, self::FONT_BOLD, $playersText);

        if ($isOnline) {
            self::drawRightAlignedText($image, 8, self::FONT_REGULAR, $gray, 'игроков онлайн', $width, 18, 46);
        }

        self::drawFooterDomain($image, $textX, $height);

        self::output($image);
    }

    private static function renderLeaderboard(array $server): void
    {
        [$width, $height] = self::dimensions('leaderboard');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, 6, $height, $accent);

        $white = imagecolorallocate($image, 255, 255, 255);
        $gray = imagecolorallocate($image, 150, 155, 165);

        self::drawGameIcon($image, $server['game'] ?? '', 24, 13, 64, 64);

        $textX = 104;
        $hostname = self::truncate(strip_tags($server['hostname'] ?? ''), 42);
        imagettftext($image, 15, 0, $textX, 32, $white, self::FONT_BOLD, $hostname);

        $address = ($server['host'] ?: $server['ip']) . ':' . $server['port'];
        imagettftext($image, 10, 0, $textX, 50, $gray, self::FONT_REGULAR, $address);

        $map = 'Карта: ' . self::truncate($server['map'] ?? '-', 30);
        imagettftext($image, 10, 0, $textX, 67, $gray, self::FONT_REGULAR, $map);

        self::drawMapThumbnail($image, $server['game'] ?? '', $server['map'] ?? '', $width - 234, 13, 96, 64);

        $playersText = $isOnline ? $server['players'] . ' / ' . $server['max_players'] : 'OFFLINE';
        $bbox = imagettfbbox(24, 0, self::FONT_BOLD, $playersText);
        $textWidth = abs($bbox[4] - $bbox[0]);
        imagettftext($image, 24, 0, $width - 24 - $textWidth, 50, $accent, self::FONT_BOLD, $playersText);

        if ($isOnline) {
            self::drawRightAlignedText($image, 9, self::FONT_REGULAR, $gray, 'игроков онлайн', $width, 24, 68);
        }

        self::drawFooterDomain($image, $textX, $height);

        self::output($image);
    }

    private static function renderSkyscraper(array $server): void
    {
        [$width, $height] = self::dimensions('skyscraper');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, $width, 6, $accent);

        $white = imagecolorallocate($image, 255, 255, 255);
        $gray = imagecolorallocate($image, 150, 155, 165);

        self::drawGameIcon($image, $server['game'] ?? '', (int)(($width - 90) / 2), 28, 90, 90);

        $hostnameLines = self::wrapLines(13, self::FONT_BOLD, strip_tags($server['hostname'] ?? ''), $width - 24, 3);
        $y = 148;
        foreach ($hostnameLines as $line) {
            self::drawCenteredText($image, 13, self::FONT_BOLD, $white, $line, $width, $y);
            $y += 20;
        }

        $y += 6;
        $address = ($server['host'] ?: $server['ip']) . ':' . $server['port'];
        self::drawCenteredText($image, 10, self::FONT_REGULAR, $gray, $address, $width, $y);
        $y += 20;

        $map = 'Карта: ' . self::truncate($server['map'] ?? '-', 20);
        self::drawCenteredText($image, 10, self::FONT_REGULAR, $gray, $map, $width, $y);
        $y += 26;

        $lineColor = imagecolorallocate($image, 45, 48, 56);
        imageline($image, 20, $y, $width - 20, $y, $lineColor);
        $y += 60;

        $playersText = $isOnline ? (string)$server['players'] : '—';
        self::drawCenteredText($image, 42, self::FONT_BOLD, $accent, $playersText, $width, $y);
        $y += 28;

        $subText = $isOnline ? 'из ' . $server['max_players'] : 'OFFLINE';
        self::drawCenteredText($image, 13, self::FONT_REGULAR, $gray, $subText, $width, $y);
        $y += 26;

        if ($isOnline) {
            self::drawCenteredText($image, 10, self::FONT_REGULAR, $gray, 'игроков онлайн', $width, $y);
        }

        self::drawFooterDomain($image, 16, $height - 34);

        $statusBg = $accent;
        imagefilledrectangle($image, 0, $height - 30, $width, $height, $statusBg);
        $dark = imagecolorallocate($image, 24, 26, 32);
        $statusText = $isOnline ? 'ONLINE' : 'OFFLINE';
        self::drawCenteredText($image, 11, self::FONT_BOLD, $dark, $statusText, $width, $height - 9);

        self::output($image);
    }

    private static function renderCard(array $server): void
    {
        [$width, $height] = self::dimensions('card');
        $image = imagecreatetruecolor($width, $height);

        $bg = imagecolorallocate($image, 24, 26, 32);
        imagefilledrectangle($image, 0, 0, $width, $height, $bg);

        $isOnline = self::isOnline($server);
        $accent = self::accentColor($image, $isOnline);
        imagefilledrectangle($image, 0, 0, $width, 6, $accent);

        $white = imagecolorallocate($image, 255, 255, 255);
        $gray = imagecolorallocate($image, 150, 155, 165);

        self::drawGameIcon($image, $server['game'] ?? '', (int)(($width - 64) / 2), 22, 64, 64);

        $hostname = self::truncate(strip_tags($server['hostname'] ?? ''), 26);
        self::drawCenteredText($image, 13, self::FONT_BOLD, $white, $hostname, $width, 112);

        $address = ($server['host'] ?: $server['ip']) . ':' . $server['port'];
        self::drawCenteredText($image, 9, self::FONT_REGULAR, $gray, $address, $width, 128);

        $map = 'Карта: ' . self::truncate($server['map'] ?? '-', 26);
        self::drawCenteredText($image, 9, self::FONT_REGULAR, $gray, $map, $width, 143);

        imageline($image, 24, 155, $width - 24, 155, imagecolorallocate($image, 45, 48, 56));

        $playersText = $isOnline ? $server['players'] . ' / ' . $server['max_players'] : 'OFFLINE';
        self::drawCenteredText($image, 28, self::FONT_BOLD, $accent, $playersText, $width, 205);

        if ($isOnline) {
            self::drawCenteredText($image, 9, self::FONT_REGULAR, $gray, 'игроков онлайн', $width, 220);
        }

        $statusBg = $accent;
        imagefilledrectangle($image, 0, $height - 28, $width, $height, $statusBg);
        $statusText = $isOnline ? 'ONLINE' : 'OFFLINE';
        $dark = imagecolorallocate($image, 24, 26, 32);
        self::drawCenteredText($image, 10, self::FONT_BOLD, $dark, $statusText, $width, $height - 9);

        self::output($image);
    }

    private static function dimensions(string $variant): array
    {
        $meta = self::VARIANTS[$variant] ?? self::VARIANTS[self::DEFAULT_VARIANT];
        return [$meta['width'], $meta['height']];
    }

    private static function isOnline(array $server): bool
    {
        return (int)($server['status'] ?? 0) === 1 && (int)($server['ban'] ?? 0) === 0;
    }

    private static function accentColor($image, bool $isOnline)
    {
        return $isOnline
            ? imagecolorallocate($image, 46, 204, 113)
            : imagecolorallocate($image, 231, 76, 60);
    }

    private static function drawGameIcon($image, string $game, int $x, int $y, int $w, int $h): void
    {
        $iconFile = self::GAME_ICONS[$game] ?? null;
        if ($iconFile === null) {
            return;
        }

        self::drawIcon($image, ROOT_DIR . 'public/img/gameicons/' . $iconFile, $x, $y, $w, $h);
    }

    private static function drawMapThumbnail($image, string $game, ?string $map, int $x, int $y, int $w, int $h): void
    {
        $relativePath = Servers::getImagePath((string)$map, $game);
        self::drawIcon($image, ROOT_DIR . ltrim($relativePath, '/'), $x, $y, $w, $h);
    }

    private static function wrapLines(int $fontSize, string $font, string $text, int $maxWidth, int $maxLines): array
    {
        $words = array_values(array_filter(preg_split('/\s+/u', trim($text)) ?: [], static function ($word) {
            return $word !== '';
        }));

        $lines = [];
        $current = '';
        $i = 0;
        $count = count($words);

        while ($i < $count) {
            $word = $words[$i];
            $test = $current === '' ? $word : $current . ' ' . $word;
            $bbox = imagettfbbox($fontSize, 0, $font, $test);
            $width = abs($bbox[4] - $bbox[0]);

            if ($width > $maxWidth && $current !== '') {
                $lines[] = $current;
                $current = '';
                if (count($lines) === $maxLines) {
                    break;
                }
                continue;
            }

            $current = $test;
            $i++;
        }

        $hasMore = $i < $count;

        if ($current !== '' && count($lines) < $maxLines) {
            $lines[] = $current;
        } elseif ($current !== '') {
            $hasMore = true;
        }

        if ($hasMore && !empty($lines)) {
            $lastIndex = count($lines) - 1;
            $last = $lines[$lastIndex];
            while (mb_strlen($last) > 1) {
                $bbox = imagettfbbox($fontSize, 0, $font, $last . '…');
                if (abs($bbox[4] - $bbox[0]) <= $maxWidth) {
                    break;
                }
                $last = mb_substr($last, 0, -1);
            }
            $lines[$lastIndex] = rtrim($last) . '…';
        }

        return $lines ?: [''];
    }

    private static function drawFooterDomain($image, int $x, int $height): void
    {
        $host = BASE_URL !== '' ? (parse_url(BASE_URL, PHP_URL_HOST) ?: BASE_URL) : ($_SERVER['SERVER_NAME'] ?? '');
        if (!$host) {
            return;
        }

        $gray = imagecolorallocate($image, 150, 155, 165);
        imagettftext($image, 7, 0, $x, $height - 6, $gray, self::FONT_REGULAR, $host);
    }

    private static function drawRightAlignedText($image, int $fontSize, string $font, $color, string $text, int $canvasWidth, int $rightPadding, int $y): void
    {
        $bbox = imagettfbbox($fontSize, 0, $font, $text);
        $textWidth = abs($bbox[4] - $bbox[0]);
        imagettftext($image, $fontSize, 0, $canvasWidth - $rightPadding - $textWidth, $y, $color, $font, $text);
    }

    private static function drawCenteredText($image, int $fontSize, string $font, $color, string $text, int $canvasWidth, int $y): void
    {
        $bbox = imagettfbbox($fontSize, 0, $font, $text);
        $textWidth = abs($bbox[4] - $bbox[0]);
        imagettftext($image, $fontSize, 0, (int)(($canvasWidth - $textWidth) / 2), $y, $color, $font, $text);
    }

    private static function output($image, bool $cacheable = true): void
    {
        header('Content-Type: image/png');
        if ($cacheable) {
            header('Cache-Control: no-cache, must-revalidate');
            header('Pragma: no-cache');
        }

        imagepng($image);
        imagedestroy($image);
        exit;
    }

    private static function drawIcon($image, string $path, int $x, int $y, int $w, int $h): void
    {
        if (!file_exists($path)) {
            return;
        }

        $ext = strtolower(pathinfo($path, PATHINFO_EXTENSION));

        switch ($ext) {
            case 'png':
                $source = @imagecreatefrompng($path);
                break;
            case 'jpg':
            case 'jpeg':
                $source = @imagecreatefromjpeg($path);
                break;
            default:
                $source = null;
        }

        if (!$source) {
            return;
        }

        imagesavealpha($source, true);
        imagecopyresampled($image, $source, $x, $y, 0, 0, $w, $h, imagesx($source), imagesy($source));
        imagedestroy($source);
    }

    private static function truncate(string $value, int $length): string
    {
        return mb_strlen($value) > $length ? mb_substr($value, 0, $length - 1) . '…' : $value;
    }
}
