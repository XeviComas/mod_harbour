#xcommand ? <cText> => AP_RPuts( <cText> )
#xcommand TEXT INTO <v> => #pragma __cstream|<v>:=%s
FUNCTION ViewDbf()
    LOCAL cAlias

    REQUEST DBFCDX

    //  Abrimos Dbf...

        USE ( '/var/www/test/customer' ) SHARED NEW

        cAlias := Alias()

    //  ViewDbf

        MyView( cAlias )

RETU NIL
FUNCTION MyView( cAlias, aStr )
    ? DefineWeb()
    ? DefineNav()
        ShowTable( cAlias, aStr )
    ? DefineEnd()
RETU NIL
FUNCTION DefineWeb()
    LOCAL cHtml := ''

TEXT INTO cHtml
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
ENDTEXT
RETU cHtml
FUNCTION DefineEnd()
    LOCAL cHtml := ''

TEXT INTO cHtml
</body>
</html>
ENDTEXT
RETU cHtml
FUNCTION DefineNav()
    LOCAL cHtml := ''
TEXT INTO cHtml
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Harbour for Web</a>
    </div>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul>
  </div>
</nav>
ENDTEXT
RETU cHtml
FUNCTION ShowTable( cAlias )
    LOCAL cHtml := ''
    LOCAL aStr  := (cAlias)->( DbStruct() )
    ? '<h2>Table: ' + cAlias + '</h2>'

TEXT INTO cHtml
<table class="table table-hover">
    <thead>
    <tr>
    </thead>';
ENDTEXT
    ? cHtml

    //  Cabecera...

        nFields = len( aStr );

        for i = 1 TO nFields

            ? '<th>' + aStr[i][1] + '</th>'

        next

        ? '</thead>'

    //  Datos...

        while ( (cAlias)->(!eof()) )

            ? '<tr>'

            for i = 1 TO nFields

                ? '<td>' + ValToChar( (cAlias)->(fieldget(i)) ) + '</td>'
            next

            ? '</tr>'

            (cAlias)->( DbSkip())

        end
    ? '</table>'

RETU NIL
