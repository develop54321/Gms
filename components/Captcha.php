<?php

namespace components;

class Captcha
{
    private string $sessionKey = 'captcha_code';
    private int $length = 5;

    private int $width = 140;
    private int $height = 40;
    private int $fontSize = 28;

    private string $fontPath = ROOT_DIR. 'public/fonts/ofont.ru_SouthGhetto.ttf';

    public function __construct()
    {
        if (session_status() !== PHP_SESSION_ACTIVE) {
            session_start();
        }

        if (!file_exists($this->fontPath)) {
            throw new \Exception('Captcha font not found');
        }

    }

    public function generateCode(string $key): string
    {
        $code = '';
        $chars = '23456789ABCDEFGHJKLMNPQRSTUVWXYZ';

        for ($i = 0; $i < $this->length; $i++) {
            $code .= $chars[random_int(0, strlen($chars) - 1)];
        }

        $_SESSION['captcha_tokens'][$key] = $code;

        return $code;
    }

    public function render(string $key): void
    {
        $code = $this->generateCode($key);
        $image = imagecreatetruecolor($this->width, $this->height);

        // Цвета
        $background = imagecolorallocate($image, 20, 20, 20);
        imagefilledrectangle($image, 0, 0, $this->width, $this->height, $background);

        // Линии шума
        for ($i = 0; $i < 5; $i++) {
            $lineColor = imagecolorallocate(
                $image,
                random_int(100, 200),
                random_int(100, 200),
                random_int(100, 200)
            );
            imageline(
                $image,
                random_int(0, $this->width),
                random_int(0, $this->height),
                random_int(0, $this->width),
                random_int(0, $this->height),
                $lineColor
            );
        }

        // Шумовые точки и эллипсы
        for ($i = 0; $i < 150; $i++) {
            $shapeColor = imagecolorallocate(
                $image,
                random_int(50, 180),
                random_int(50, 180),
                random_int(50, 180)
            );
            if (random_int(0, 1)) {
                imagesetpixel($image, random_int(0, $this->width), random_int(0, $this->height), $shapeColor);
            } else {
                imagefilledellipse(
                    $image,
                    random_int(0, $this->width),
                    random_int(0, $this->height),
                    random_int(1, 3),
                    random_int(1, 3),
                    $shapeColor
                );
            }
        }

        // Текст с разными цветами и смещением
        $x = 10;
        for ($i = 0; $i < strlen($code); $i++) {
            $charColor = imagecolorallocate(
                $image,
                random_int(200, 255),
                random_int(200, 255),
                random_int(200, 255)
            );
            $y = $this->height - 10 + random_int(-5, 5);
            $angle = random_int(-10, 10);
            imagettftext($image, $this->fontSize, $angle, $x, $y, $charColor, $this->fontPath, $code[$i]);
            $x += $this->fontSize - 2;
        }

        header('Content-Type: image/png');
        header('Cache-Control: no-store, no-cache, must-revalidate');
        header('Pragma: no-cache');

        imagepng($image);
        imagedestroy($image);
        exit;
    }

    public function validate(string $input, string $key): bool
    {
        if (!isset($_SESSION['captcha_tokens'][$key])) {
            return false;
        }

        $stored = mb_strtoupper($_SESSION['captcha_tokens'][$key], 'UTF-8');
        $input  = mb_strtoupper(trim($input), 'UTF-8');

        unset($_SESSION['captcha_tokens'][$key]); // одноразовая капча

        return $stored === $input;
    }
}