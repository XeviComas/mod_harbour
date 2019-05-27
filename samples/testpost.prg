#xcommand TEMPLATE => #pragma __cstream | AP_RPuts( Template( %s ) )

#define CRLF hb_OsNewLine()

function Main()

   TEMPLATE
<html>
  <head>
    <meta charset="utf-8">
    <title>Ejemplo método POST en el atributo method</title>
  </head>
  <body>
    <form action="postpairs.prg" method="post">
      Nombre de usuario:
      <br>
      <input type="text" name="usuario">
      <br>
      Contraseña:
      <br>
      <input type="password" name="clave">
      <br><br>
      <input type="submit" value="Enviar datos">
    </form>
  </body>
</html>
   ENDTEXT

return nil

function Template( cText )

   local nStart, nEnd, cCode

   while ( nStart := At( "<?prg", cText ) ) != 0
      nEnd = At( "?>", SubStr( cText, nStart + 5 ) )
      cCode = SubStr( cText, nStart + 5, nEnd - 1 )
      cText = SubStr( cText, 1, nStart - 1 ) + Replace( cCode ) + SubStr( cText, nStart + nEnd + 6 )
   end

return cText

function Replace( cCode )

return Execute( "function __Inline()" + HB_OsNewLine() + cCode )
