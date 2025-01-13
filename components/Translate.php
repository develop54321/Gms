<?php

namespace components;

class Translate {
    private $translations = [];
    private $lang = 'en';

    public function __construct($lang = 'en') {
        $this->lang = $lang;
        $this->loadTranslations();
    }

    private function loadTranslations() {
        $file = __DIR__ . "/lang/{$this->lang}.php";
        if (file_exists($file)) {
            $this->translations = include $file;
        }
    }

    public function get($key, $replacements = []) {
        $text = $this->translations[$key] ?? $key;

        foreach ($replacements as $placeholder => $value) {
            $text = str_replace(":$placeholder", $value, $text);
        }

        return $text;
    }
}
