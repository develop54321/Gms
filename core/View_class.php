<?php
class View{
        protected $dir_tmpl;
    
        public function __construct($dir_tmpl){
            $this->dir_tmpl = $dir_tmpl."/";
           
        }
    
        public function render($file, $params){
        $template = $this->dir_tmpl.$file.".tpl";
        extract($params);
        ob_start();
        include($template);
        echo ob_get_clean();

        if(isset($params['global_error'])) exit();
        }
        

        public function renderPartial($file, $params = null){
        $template = $this->dir_tmpl.$file.".tpl";
        extract($params);
        ob_start();
        include($template);
        return ob_get_clean();
        }
}