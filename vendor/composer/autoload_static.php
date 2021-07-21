<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53
{
    public static $prefixLengthsPsr4 = array (
        'x' => 
        array (
            'xPaw\\SourceQuery\\' => 17,
        ),
        'c' => 
        array (
            'core\\' => 5,
            'controllers\\' => 12,
            'components\\' => 11,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'xPaw\\SourceQuery\\' => 
        array (
            0 => __DIR__ . '/..' . '/xpaw/php-source-query-class/SourceQuery',
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
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit20bdcbb218edd010a7faa4ccf3fb0f53::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
