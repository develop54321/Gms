<?php
namespace components;
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