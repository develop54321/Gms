<?php
namespace components;

use core\BaseController;

class Pagination extends BaseController
{
    public function create($array)
    {
        $per_page = $array['per_page']; // Количество элементов на странице
        $total_items = $array['count']; // Общее количество элементов

        // Определение текущей страницы
        $current_page = isset($_GET['page']) && is_numeric($_GET['page']) ? max(1, intval($_GET['page'])) : 1;

        // Подсчет общего количества страниц
        $total_pages = max(1, ceil($total_items / $per_page));

        // Корректировка текущей страницы
        $current_page = min($current_page, $total_pages);

        $start = ($current_page - 1) * $per_page; // Индекс первого элемента на текущей странице

        // Построение базового URL
        $symbol = "?";
        $getUrl = $array['no_rgp'] ?? false ?
            $this->removeqsvar($_SERVER['REQUEST_URI'], "page") :
            self::rgp($_SERVER['REQUEST_URI']);

        $symbol = strpos($getUrl, '?') !== false ? '&' : '?';

        $pagination = [];

        // Добавляем кнопку "Назад"
        if ($current_page > 1) {
            $pagination[] = $this->createPageLink($getUrl, $symbol, $current_page - 1, "Назад", "back");
        }

        // Диапазон видимых страниц
        $visible_range = 5;
        $start_page = max(1, $current_page - floor($visible_range / 2));
        $end_page = min($total_pages, $start_page + $visible_range - 1);

        if ($end_page - $start_page + 1 < $visible_range) {
            $start_page = max(1, $end_page - $visible_range + 1);
        }

        // Добавляем первую страницу и "..."
        if ($start_page > 1) {
            $pagination[] = $this->createPageLink($getUrl, $symbol, 1, "1");
            if ($start_page > 2) {
                $pagination[] = $this->createEllipsis();
            }
        }

        // Добавляем диапазон страниц
        for ($i = $start_page; $i <= $end_page; $i++) {
            $pagination[] = $i == $current_page ?
                $this->createCurrentPage($i) :
                $this->createPageLink($getUrl, $symbol, $i, $i);
        }

        // Добавляем "..." и последнюю страницу
        if ($end_page < $total_pages) {
            if ($end_page < $total_pages - 1) {
                $pagination[] = $this->createEllipsis();
            }
            $pagination[] = $this->createPageLink($getUrl, $symbol, $total_pages, $total_pages);
        }

        // Добавляем кнопку "Вперед"
        if ($current_page < $total_pages) {
            $pagination[] = $this->createPageLink($getUrl, $symbol, $current_page + 1, "Вперед", "next");
        }

        return ['ViewPagination' => $pagination, 'start' => $start];
    }

    private function createPageLink($url, $symbol, $page, $label, $class = "")
    {
        return '<li class="page-item"><a class="page-link ' . $class . '" href="' . $url . $symbol . 'page=' . $page . '">' . $label . '</a></li>';
    }

    private function createCurrentPage($page)
    {
        return '<li class="page-item active" aria-current="page"><a class="page-link disabled">' . $page . '</a></li>';
    }

    private function createEllipsis()
    {
        return '<li class="page-item"><a class="page-link disabled">...</a></li>';
    }

    public static function rgp($url)
    {
        return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
    }

    public function removeqsvar($url, $varname)
    {
        list($urlpart, $qspart) = array_pad(explode('?', $url), 2, '');
        parse_str($qspart, $qsvars);
        unset($qsvars[$varname]);
        $newqs = http_build_query($qsvars);
        return $urlpart . ($newqs ? '?' . $newqs : '');
    }
}



/*namespace components;
use core\BaseController;

class Pagination extends BaseController
{

    public function create($array)
    {
        $per_page = $array['per_page'];

        if (isset($_GET['page'])) $page = ($_GET['page'] - 1); else $page = 0;

        $start = abs($page * $per_page);
        $symbol = "?";
        if (isset($array['no_rgp'])) {
            $getUrl = $_SERVER['REQUEST_URI'];
            $symbol = "&";
            $getUrl = $this->removeqsvar($getUrl, "page");
        } else {

            $getUrl = self::rgp($_SERVER['REQUEST_URI']);

        }

        $num_pages = ceil($array['count'] / $per_page);

        $ViewPagination = [];
        $backButton = $page;
        $i = 1;
        if ($page != '0') {
            $link = $getUrl.$symbol."page=".$backButton;
            $ViewPagination[] = ['<li class="page-item"><a class="page-link" href="'.$link.'" class="back">Назад</a>'];
        }
        $num_pages_for = $num_pages;

        if ($num_pages > '5') {
            $num_pages_for = $page + 5;
        }
        if ($page >= 5) $i = $page - 5;

        for ($i; $i <= $num_pages_for; $i++) {
            if ($i - 1 == $page) {
                $ViewPagination[] = ['<li class="page-item active" aria-current="page"><span class="page-link">' . $i . '</span></li>'];
            } else {
                $ViewPagination[] = ['<li class="page-item"><a class="page-link" href="' . $getUrl . $symbol . 'page=' . $i . '">' . $i . '</a></li>'];
            }
        }

        if ($num_pages > '5') {
            $ViewPagination[] = ['<li class="page-item"><a class="page-link" href="#">...</a></li>'];
            $ViewPagination[] = ['<li class="page-item"><a class="page-link" href="' . $getUrl . $symbol . 'page=' . $num_pages . '">' . $num_pages . '</a></li>'];
        }

        $forwardButton = $page + 2;

        if ($forwardButton < $num_pages + 1) {
            $link = $getUrl.$symbol."page=".$forwardButton;
            $ViewPagination[] = ['<li class="page-item"><a class="page-link" href="'.$link.'" class="next">Вперед</a>'];
        }



        return ['ViewPagination' => $ViewPagination, 'start' => $start];


    }

    public static function rgp($url)
    {
        return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
    }

    function removeqsvar($url, $varname)
    {
        list($urlpart, $qspart) = array_pad(explode('?', $url), 2, '');
        parse_str($qspart, $qsvars);
        unset($qsvars[$varname]);
        $newqs = http_build_query($qsvars);
        return $urlpart . '?' . $newqs;
    }

}
*/