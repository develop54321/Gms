<?php
class Pagination extends BaseController{
    
    public function create($array){
    $per_page = $array['per_page'];
        
    if (isset($_GET['page'])) $page=($_GET['page']-1); else $page=0;
    $start=abs($page*$per_page);
    $symbol = "?";
    if(isset($array['no_rgp'])){
        $getUrl = $_SERVER['REQUEST_URI'];
        $symbol = "&";
        $getUrl = $this->removeqsvar($getUrl, "page");
        }else{
        
        $getUrl = self::rgp($_SERVER['REQUEST_URI']); 
      
    }

    $num_pages = ceil($array['count']/$per_page);
    
    $ViewPagination = [];
    $backButton = $page;
  
    if($page != '0'){
    $ViewPagination[] = ["<a href='".$getUrl.$symbol."page=$backButton'><i class='fa fa-arrow-left'></i></a>"];
    }
    $num_pages_for = $num_pages;
    if($num_pages > '5'){
        $num_pages_for = 5;
    }

   
    for($i=1;$i<=$num_pages_for;$i++) {
    if ($i-1 == $page) {
    $ViewPagination[] = ['<a class="actual">'.$i.'</a>'];  
    } else {
    $ViewPagination[] = ['<a href="'.$getUrl.$symbol.'page='.$i.'">'.$i.'</a>'];  
    }
    }
    
    if($num_pages > '5'){
    $ViewPagination[] = ['<a href="#">...</a>'];  
    $ViewPagination[] = ['<a href="'.$getUrl.$symbol.'page='.$num_pages.'">'.$num_pages.'</a>'];  
    }
    
    
    
    $forwardButton = $page+2;
  
    if($forwardButton < $num_pages+1){
    $ViewPagination[] = ["<a href='".$getUrl.$symbol."page=$forwardButton'><i class='fa fa-arrow-right'></i></a>"];
    }
    
     

    
    return ['ViewPagination' => $ViewPagination, 'start' => $start];
    

    }
    
    public static function rgp($url) {
    return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
    }

     function removeqsvar($url, $varname) {
        list($urlpart, $qspart) = array_pad(explode('?', $url), 2, '');
        parse_str($qspart, $qsvars);
        unset($qsvars[$varname]);
        $newqs = http_build_query($qsvars);
        return $urlpart . '?' . $newqs;
    }
    
}