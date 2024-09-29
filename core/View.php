<?php

namespace core;

class View
{
    protected string $dir_tmpl;

    public function __construct(string $dir_tmpl)
    {
        $this->dir_tmpl = rtrim($dir_tmpl, '/') . '/';
    }

    protected function loadTemplate(string $file): string
    {
        return $this->dir_tmpl . $file . '.tpl';
    }

    protected function extractAndInclude(string $template, array $params = []): string
    {
        if (!empty($params)) {
            extract($params);
        }

        ob_start();
        include $template;
        return ob_get_clean();
    }

    public function render(string $file, array $params = []): void
    {
        $template = $this->loadTemplate($file);
        echo $this->extractAndInclude($template, $params);

        if (isset($params['global_error'])) {
            exit();
        }
    }

    public function renderPartial(string $file, array $params = []): string
    {
        $template = $this->loadTemplate($file);
        return $this->extractAndInclude($template, $params);
    }
}
