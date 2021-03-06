<!DOCTYPE html>
<html>
    <script type='text/javascript' src='/tpl/js/player.js'></script>

    <head>
        <meta charset="UTF-8">
        <title>Cosmosium | {{pageTitle}}</title>

        <!-- websocket connection -->
        <script type='text/javascript' src='/js/objectDB.js'></script>
        <!--
        <script type='text/javascript' src='/js/wsMessageParser.js'></script>
        -->
        <script type="text/javascript">
            parseMessage = function(m){
                console.log('received message: ' + m)
            }
        </script>
        <script type='text/javascript' src='/js/createMessage.js'></script>
    </head>
    <body>

        <ol>
            <li>
                <a href="#" onclick="console.log('console logger test')">console logger test</a>
            </li>
            <li>
                <a href="#" onclick="asteroid_survey('NEO',10)"> asteroid survey test</a>
            </li>
        </ol>

        <script type='text/javascript'>
            asteroid_survey = function(newSurvey, asteroidPollAmount){
                ws.send(message('getSurvey',"{'survey': '" + newSurvey + "', 'amt': " + asteroidPollAmount + "}"));
            };
        </script>

        <!-- WEBSOCKETS !IMPORTANT! -->
        <script type="text/javascript" src='/tpl/js/webSocketSetup.js'></script>
        <script type="text/javascript">
            // overwrite the ws.onopen defined in webSocketSetup
            ws.onopen = function() {
                ws.send(message("hello"));
                console.log('websocket connection opened');
            };
        </script>

    </body>
</html>