<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53
{
    public static $files = array (
        '23c18046f52bef3eea034657bafda50f' => __DIR__ . '/..' . '/symfony/polyfill-php81/bootstrap.php',
        '320cde22f66dd4f5d3fd621d3e88b98f' => __DIR__ . '/..' . '/symfony/polyfill-ctype/bootstrap.php',
        'e39a8b23c42d4e1452234d762b03835a' => __DIR__ . '/..' . '/ramsey/uuid/src/functions.php',
    );

    public static $prefixLengthsPsr4 = array (
        'x' => 
        array (
            'xPaw\\SourceQuery\\' => 17,
        ),
        'w' => 
        array (
            'widgets\\' => 8,
        ),
        'c' => 
        array (
            'core\\' => 5,
            'controllers\\' => 12,
            'components\\' => 11,
        ),
        'S' => 
        array (
            'Symfony\\Polyfill\\Php81\\' => 23,
            'Symfony\\Polyfill\\Ctype\\' => 23,
        ),
        'R' => 
        array (
            'ReCaptcha\\' => 10,
            'Ramsey\\Uuid\\' => 12,
            'Ramsey\\Collection\\' => 18,
        ),
        'Q' => 
        array (
            'Qiwi\\Api\\' => 9,
        ),
        'G' => 
        array (
            'GameQ\\' => 6,
        ),
        'B' => 
        array (
            'Brick\\Math\\' => 11,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'xPaw\\SourceQuery\\' => 
        array (
            0 => __DIR__ . '/..' . '/xpaw/php-source-query-class/SourceQuery',
        ),
        'widgets\\' => 
        array (
            0 => __DIR__ . '/../..' . '/widgets',
        ),
        'core\\' => 
        array (
            0 => __DIR__ . '/../..' . '/core',
        ),
        'controllers\\' => 
        array (
            0 => __DIR__ . '/../..' . '/controllers',
        ),
        'components\\' => 
        array (
            0 => __DIR__ . '/../..' . '/components',
        ),
        'Symfony\\Polyfill\\Php81\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-php81',
        ),
        'Symfony\\Polyfill\\Ctype\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-ctype',
        ),
        'ReCaptcha\\' => 
        array (
            0 => __DIR__ . '/..' . '/google/recaptcha/src/ReCaptcha',
        ),
        'Ramsey\\Uuid\\' => 
        array (
            0 => __DIR__ . '/..' . '/ramsey/uuid/src',
        ),
        'Ramsey\\Collection\\' => 
        array (
            0 => __DIR__ . '/..' . '/ramsey/collection/src',
        ),
        'Qiwi\\Api\\' => 
        array (
            0 => __DIR__ . '/..' . '/qiwi/bill-payments-php-sdk/src',
        ),
        'GameQ\\' => 
        array (
            0 => __DIR__ . '/..' . '/austinb/gameq/src/GameQ',
        ),
        'Brick\\Math\\' => 
        array (
            0 => __DIR__ . '/..' . '/brick/math/src',
        ),
    );

    public static $classMap = array (
        'ReturnTypeWillChange' => __DIR__ . '/..' . '/symfony/polyfill-php81/Resources/stubs/ReturnTypeWillChange.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53::$classMap;

        }, null, ClassLoader::class);
    }
}
