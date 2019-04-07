<?php
 function __autoload($class_name) 
    {
        $directorys = array(
            'core/',
            'controllers/',
            'controllers/control/',
            'components/'
        );
        

        foreach($directorys as $directory)
        {

            if(file_exists($directory.$class_name . '.php'))
            {
                require_once($directory.$class_name . '.php');
                 return;
            }    
            
            if(file_exists($directory.$class_name . '_class.php'))
            {
                require_once($directory.$class_name . '_class.php');
                   return;
            }          
        }
    }
