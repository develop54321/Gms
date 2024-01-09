<?php

namespace widgets\money;

use core\View;
use core\WidgetsInterface;

final class Money implements WidgetsInterface
{

    public static function run($params = null): string{
         return  number_format($params, 2, '.', ' ') . ' руб.';
    }
}