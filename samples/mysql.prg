#xcommand ? <cText> => AP_RPuts( <cText> )

#define HB_DYN_CALLCONV_CDECL       0x0000000  // C default
#define HB_DYN_CTYPE_LONG_UNSIGNED  0x0000014
#define HB_DYN_CTYPE_CHAR_PTR       0x0000101
#define HB_DYN_CTYPE_LONG           0x0000004
#define HB_DYN_CTYPE_INT            0x0000003
#define NULL                        0x0000000         

static pLib, hMySQL, hConnection

//----------------------------------------------------------------//

function Main()

   local nRetVal
   
   pLib = hb_LibLoad( "/usr/lib/x86_64-linux-gnu/libmysqlclient.so" ) // libmysqlclient.so.20 for mariaDB
   hMySQL = mysql_init()

   ? "pLib = " + ValType( pLib ) + ;
      If( ValType( pLib ) == "P", " (MySQL library properly loaded)", " (MySQL library not found)" ) + '<br>'
   
   ? "hMySQL = " + Str( hMySQL ) + ;
      If( hMySQL != 0, " (MySQL library properly initalized)", " (MySQL library failed to initialize)" ) + '<br>'

   ? "Connection: "
   ? hConnection := mysql_real_connect( "127.0.0.1", "harbour", "password", "dbHarbour", 3306 )
   ? If( hConnection != hMySQL, " (Failed connection)", " (Successfull connection)" )
   ? '<br>'

   if hConnection != 0
      if ( nRetVal := mysql_query( hConnection, "select * from users" ) ) == 0
         ? "MySQL query succeded<br>"
      else
         ? "MySQL query failed<br>"
         ? "error: " + Str( nRetVal ) + "</br>"
      endif
   endif   

   mysql_close( hMySQL )
   
   ? "MySQL library properly freed: "
   ? HB_LibFree( pLib )                        

return nil

//----------------------------------------------------------------//

function mysql_init()

return hb_DynCall( { "mysql_init", pLib, HB_DYN_CALLCONV_CDECL }, NULL )

//----------------------------------------------------------------//

function mysql_close( hMySQL )

return hb_DynCall( { "mysql_close", pLib, HB_DYN_CALLCONV_CDECL, HB_DYN_CTYPE_LONG_UNSIGNED }, hMySQL )

//----------------------------------------------------------------//

function mysql_real_connect( cServer, cUserName, cPassword, cDataBaseName, nPort )

   if nPort == nil
      nPort = 3306
   endif   

return hb_DynCall( { "mysql_real_connect", pLib, hb_bitOr( HB_DYN_CTYPE_LONG_UNSIGNED, HB_DYN_CALLCONV_CDECL ),;
                     HB_DYN_CTYPE_LONG_UNSIGNED,;
                     HB_DYN_CTYPE_CHAR_PTR, HB_DYN_CTYPE_CHAR_PTR, HB_DYN_CTYPE_CHAR_PTR, HB_DYN_CTYPE_CHAR_PTR,;
                     HB_DYN_CTYPE_LONG, HB_DYN_CTYPE_LONG, HB_DYN_CTYPE_LONG },;
                     hMySQL, cServer, cUserName, cPassword, cDataBaseName, nPort, 0, 0 )
                     
//----------------------------------------------------------------//

function mysql_query( hConnect, cQuery )

return hb_DynCall( { "mysql_query", pLib, hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_CDECL ),;
                   HB_DYN_CTYPE_LONG_UNSIGNED, HB_DYN_CTYPE_CHAR_PTR },;
                   hConnect, cQuery )

//----------------------------------------------------------------//
