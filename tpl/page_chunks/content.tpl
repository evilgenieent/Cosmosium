<!DOCTYPE html>
<html>
    <script type="application/javascript">

    </script>
    <script type='text/javascript' src='/tpl/js/player.js'></script>


    <head>
        <meta charset="UTF-8">
        <title>Cosmosium | {{pageTitle}}</title>        
        % if config.showFrame:
            <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
            <!-- bootstrap 3.0.2 -->
            <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
            <!-- font Awesome -->
            <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
            <!-- Ionicons -->
            <link href="css/ionicons.min.css" rel="stylesheet" type=" text/css" />
            <!-- Morris chart -->
            <link href="css/morris/morris.css" rel="stylesheet" type="text/css" />
            <!-- jvectormap -->
            <link href="css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
            <!-- fullCalendar -->
            <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />
            <!-- Daterange picker -->
            <link href="css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
            <!-- bootstrap wysihtml5 - text editor -->
            <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
            <!-- Theme style -->
            <link href="css/AdminLTE.css" rel="stylesheet" type="text/css" />

            <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
            <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
            <![endif]-->
        % end
        
        <!-- background music
        % chunks.bg_music.loadRand()
        <script type='text/javascript'>var audioAttrib = "{{chunks.bg_music.attrib}}"</script>
        <audio id="background_audio"
            % if config.music:
                autoplay="true">
            % else:
                autoplay="false">
            % end
          <source src="{{chunks.bg_music.link}}" />
        </audio> -->


        <!-- websocket connection -->
        <script type='text/javascript' src='/js/objectDB.js'></script>
        <script type='text/javascript' src='/js/wsMessageParser.js'></script>
        <script type='text/javascript' src='/js/createMessage.js'></script>
        <script type='text/javascript' src='/tpl/js/webSocketSetup.js'></script>

        <style>

            #info {
                color:#000;
                position: absolute;
                top: 0px; width: 100%;
                padding: 5px;
            }

            a {
                color: red;
            }

            #body-info-container {
                background-color: gray;
                color: white;
                position: absolute;
                top: 70px;
                right: 0px;
                width: 200px;
                padding: 5px;
                display: none;
                z-index: 1;
            }
            #claim-asteroid-button {
                color: red;
            }

            .sidebar-index {
                display: inline;
                z-index: 2;
            }

            #dash {
                display: inline;
                z-index: 1;
            }

            #canvas {
                display: inline;
                z-index: 0;
            }


            #body-info {
                font-family:Monospace;
                font-size:13px;
                text-align:center;
                font-weight: bold;

                margin: 0px;
                overflow: hidden;

            }
        </style>

        % include('tpl/page_chunks/webGL_shaders')

        <div id="canvas"></div>

        % include('tpl/page_chunks/webGL_js')
    </head>
    <body class="skin-black" style='background-color: black;'>
        <!-- top navigation bar -->
        % include('tpl/page_chunks/frame_top')

        <!-- left navigation bars -->
        % include('tpl/page_chunks/frame_left')

        <!-- Right side column. Contains the navbar and content of the page -->
        <aside class="right-side">
            <br>
            <!-- Page Header and Resource Bar -->
            <section id="resource-bar" class="content-header" >
                %   include('tpl/page_chunks/resourcebar')
            </section>
            <br>

            <!-- Dash -->
            %include('tpl/content/dash')

            <!-- object details pane -->
            <div id="body-info-container">
                <br>
                <br>
                <div id="owner-info"><b>UNCLAIMED</b></div>
                <div id="body-info">foo</div>
                <h3><a id="claim-asteroid-button" href="#">Claim this asteroid</a></h3>
            </div>
            </section><!-- /.content -->
        </aside><!-- /.right-side -->

        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <!-- jQuery UI 1.10.3 -->
        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Morris.js charts -->
        <!--
        <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        <script src="js/plugins/morris/morris.min.js" type="text/javascript"></script>
        -->
        <!-- Sparkline -->
        <script src="js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- fullCalendar -->
        <script src="js/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="js/AdminLTE/app.js" type="text/javascript"></script>

        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <!--
        <script src="js/AdminLTE/dashboard.js" type="text/javascript"></script>
        -->

        <!-- for toggling music play -->
        <script src="js/bg_music_toggle.js" type="text/javascript"></script>

        <!-- for updating the resource display -->
        <script src="/tpl/js/resourceUpdate.js" type="text/javascript" onload="setInterval(updateAll,1000)"></script>

        <!-- for updating the game time display -->
        <script src="/js/timeUpdater.js" type="text/javascript" onload="setInterval(uTime,{{user.game.getDeltaYearUpdate()}}000)"></script>

        <!-- for j-query based navigation -->
        <script src="/js/game_frame_nav.js" type="text/javascript"></script>

        <script type="text/javascript" src='/tpl/js/webSocketSetup.js'></script>
    </body>
</html>