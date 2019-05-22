#define HB_DYN_CALLCONV_CDECL               0x0000000  /* C default */
#define HB_DYN_CTYPE_LONG_UNSIGNED          0x0000014
#define HB_DYN_CTYPE_CHAR_PTR               0x0000101
#define HB_DYN_CTYPE_LONG                   0x0000004

function Main()
   local pLib := hb_LibLoad( "/usr/lib/x86_64-linux-gnu/libmysqlclient.so" )
   local hMySQL := hb_DynCall( { "mysql_init", pLib, 0 }, 0 )

   AP_RPuts( "pLib = " + ValType( pLib ) + '<br>' )
   AP_RPuts( "hMySQL = " + Str( hMySQL ) + '<br>' )

   AP_RPuts( "hb_DynCall = " )
   AP_RPuts( hb_DynCall( { "mysql_real_connect", pLib, 0, 0x0000014, 0x0000101, 0x0000101, 0x0000101, 0x0000101,  0x0000004, 0x0000004, 0x0000004 }, hMySQL, "localhost",  "root", "mipassw", "xevi", 0, 0, 0 ) )

return nil
