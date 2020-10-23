<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><?=$title;?></title>
        <link href="/public/control/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/core.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/components.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/pages.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/responsive.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <script src="/public/control/js/modernizr.min.js"></script>
        <script src="/public/control/js/jquery.min.js"></script>
        <script src="/public/js/jquery.form.js"></script>
    </head>


    <body class="fixed-left">

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Top Bar Start -->
            <div class="topbar">

                <!-- LOGO -->
                <div class="topbar-left">
                    <div class="text-center">
                        <a href="/control" class="logo">
                        <i class="icon-magnet icon-c-logo"></i><span>GMS</span>
                        </a>

                    </div>
                </div>

               <!-- Button mobile view to collapse sidebar menu -->
                <div class="navbar navbar-default" role="navigation">
                    <div class="container">
                        <div class="">
                          
                          

                       

                            <ul class="nav navbar-nav navbar-right pull-right">
                              
                        
                               
                               
                              
                                
                                <li class="hidden-xs">
                                    <a href="/user/logout" class="right-bar-toggle waves-effect waves-light"><i class="ti-power-off"></i></a>
                                </li>
                            </ul>
                        </div>
                        <!--/.nav-collapse -->
                    </div>
                </div>
             
             
            </div>
            <!-- Top Bar End -->


            <!-- ========== Left Sidebar Start ========== -->

            <div class="left side-menu">
                <div class="sidebar-inner slimscrollleft">
                    <!--- Divider -->
                    <div id="sidebar-menu">
                        <ul>

                        	<li class="text-muted menu-title">Навигация</li>

                            <li class="has_sub">
                                <a href="/control" class="waves-effect"><i class="ti-home"></i> <span> Главная </span></a>
                            
                            </li>
							
                            <li class="has_sub">
                                <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-cog"></i><span> Настройки </span> <span class="menu-arrow"></span></a>
                                <ul class="list-unstyled" style="display: none;">
                                    <li><a href="/control/settings">Основные</a></li>
                                    <li><a href="/control/backup">Резервные копии</a></li>
                                    <li><a href="/control/paymethods">Способы оплаты</a></li>
                                    <li><a href="/control/games">Игры</a></li>
                                    <li><a href="/control/services">Тарифы</a></li>
									<li><a href="/control/codecolors">Цвета</a></li>
                                </ul>
                            </li>
							
                            <li class="has_sub">
                                <a href="/control/users" class="waves-effect"><i class="fa fa-users"></i> <span> Пользователи </span> </a>
                               
                            </li>
                            
                             <li class="has_sub">
                                <a href="/control/servers" class="waves-effect"><i class="fa fa-server"></i> <span> Серверы </span> </a>
                               
                            </li>
                            
                              <li class="has_sub">
                                <a href="/control/comments" class="waves-effect"><i class="fa fa-commenting"></i> <span> Комментарии </span> </a>
                               
                            </li>
                            
                             <li class="has_sub">
                                <a href="/control/pages" class="waves-effect"><i class="fa fa-folder"></i> <span> Страницы </span> </a>
                               
                            </li>

                            
                            
                            
                            
                            
                         
                      
                            
                            
                            <li class="has_sub">
                                <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-file-o"></i><span> Логи </span> <span class="menu-arrow"></span></a>
                                <ul class="list-unstyled" style="display: none;">
                                    <li><a href="/control/paylogs">История платежей</a></li>
                                  
                                </ul>
                            </li>



                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <!-- Left Sidebar End --> 



            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->                      
            <div class="content-page">
                <!-- Start content -->
                <div class="content">
                    <div class="container">

                        
                                
<?=$content;?>
                          
                        

                      

                        

                    </div>
                               
                </div> 

                <footer class="footer text-right">
                   Powered by <a href="https://vk.com/web2424" target="_blank">GMS</a>
                </footer>

            </div>
            
            
            <!-- ============================================================== -->
            <!-- End Right content here -->
            <!-- ============================================================== -->


           
        </div>
        <!-- END wrapper -->


    
        <script>
            var resizefunc = [];
        </script>

        <!-- jQuery  -->

        <script src="/public/control/js/bootstrap.min.js"></script>
        <script src="/public/control/js/detect.js"></script>
        <script src="/public/control/js/fastclick.js"></script>
        <script src="/public/control/js/jquery.slimscroll.js"></script>
        <script src="/public/control/js/jquery.blockUI.js"></script>
        <script src="/public/control/js/waves.js"></script>
        <script src="/public/control/js/wow.min.js"></script>
        <script src="/public/control/js/jquery.nicescroll.js"></script>
        <script src="/public/control/js/jquery.scrollTo.min.js"></script>

        <!-- Counterup  -->
        <script src="/public/control/plugins/waypoints/lib/jquery.waypoints.js"></script>
        <script src="/public/control/plugins/counterup/jquery.counterup.min.js"></script>

		
		<!--<script src="/public/control/pages/jquery.dashboard_4.js"></script>-->

        <script src="/public/control/js/jquery.core.js"></script>
        <script src="/public/control/js/jquery.app.js"></script>
        <script src="/public/js/main.js"></script>
        <script src="/public/control/plugins/bootstrap-inputmask/bootstrap-inputmask.min.js" type="text/javascript"></script>

    </body>
</html>