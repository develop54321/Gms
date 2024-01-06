<?php

namespace components;

final class Flash
{
    public static function add($type, $message): void
    {
        $_SESSION["flash"] = ['type' => $type, 'message' => $message];
    }

}