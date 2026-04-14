CLASS zcl_type_convertion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS do_something
      IMPORTING i_string      TYPE string
      RETURNING VALUE(r_text) TYPE string.


    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_type_convertion IMPLEMENTATION.


  METHOD do_something.
    r_text = i_string.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA var_string TYPE string.
    DATA var_string1 TYPE string.
    DATA var_char TYPE c LENGTH 3.
    DATA var_int TYPE i.
    DATA var_date TYPE d.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.       "packed number with length of 3 (in byte)  and two digits are reserved after the decimal point
    DATA var_n TYPE n LENGTH 4.
    DATA var_time TYPE t.
    DATA var_time_system TYPE t.
    DATA time_zone TYPE c LENGTH 6.
    DATA var_month TYPE n LENGTH 2.   " Length 2 means. how many position of the character/digit will be the output
    DATA utc_time TYPE utclong.
    DATA target_date TYPE d.
    DATA target_time TYPE t.
    DATA result_int TYPE i.

    DATA text TYPE i.




    DATA result TYPE string.
*    result = find( val = 'ABAPabapABAP' sub =  'A' ).
*    out->write( result ).
*
*    result = find( val = 'ABAPabapABAP' sub =  'A' off = 4 ).
*    out->write( result ).
*
*    result = find( val = 'ABAPabapABAP' sub =  'A' off = 4 len = 4 ).
*    out->write( result ).
*
*    result = find( val = 'ABAPabapABAP' sub =  'A' occ = 3 ).
*    out->write( result ).

    result = strlen( `  ABCD  ` ).
    out->write( result ).

    result = numofchar( `  ABCD  ` ).
    out->write( result ).

***********************************************************************************************************************************

*    result_int = numofchar( 'text' ).
*    out->write( result_int ).
*
*    result_int = find( val = 'text'  sub = 'te' ).  "finding the position of 'te' in the literal 'text* Note!! counting position starts from 0. here output will be 0
*    out->write( result_int ).
*
*    DATA result_string TYPE string.
*    result_string = replace( val = 'environment' sub = 'env' with = 'Evn' ).
*    out->write( result_string ).


**************************************************************************************************************************************
*    utc_time = utclong_current( ).
*    CONVERT UTCLONG utc_time                "breaks down a UTC timestamp into date and time
*        TIME ZONE cl_abap_context_info=>get_user_time_zone( )
*            INTO DATE target_date
*                TIME target_time.
*
*     out->write( target_date ).
*     out->write( target_time ).


*************************************************************************************************************************************
*    var_date = cl_abap_context_info=>get_system_date( ).    "Getting the system date... 20260329
*    DATA(my_year) = var_date(4).        "count off 0 character from the left and take the next first 4 character
*    DATA(my_month) = var_date+4(2).     "count off 4 character from the left and take the next 2 character
*    DATA(my_day) = var_date+6(2).       "count off 6 character from the left and take the next 2 character
*
*    out->write( my_year ).  "output 2026
*    out->write( my_month ). "output 03
*    out->write( my_day ).   "output 09

****************************************************************************************************************************************

*    var_date = cl_abap_context_info=>get_system_date( ).
*    out->write( var_date ).
*
*    var_month = var_date+4(2).  " This means start at offset 4 (count-off 4 position from left) take 2 characters. NOTE!! if the LENGTH define is longer than the extracted value ABAP will pad it '0's
*    out->write( var_month ).

*****************************************************************************************************************************************

*    var_date = cl_abap_context_info=>get_system_date( ).
*    var_time_system = cl_abap_Context_info=>get_system_time( ).
*    time_zone = cl_abap_context_info=>get_user_time_zone( ).
*
*    out->write( var_date ).
*    out->write( var_time_system ).
*    out->write( time_zone ).

********************************************************************************************************************************************


*    var_date = EXACT #( '20260329' ).
*    var_time  = '070600'.
*    out->write( |Date: { var_date DATE = ISO }   Time: { var_time TIME = ISO }| ). "use DATE/TIME = ISO to force the internal string literal to DATE/TIME format


********************************************************************************************************************************************


*    DATA var TYPE c LENGTH 10.
*    var = 'ABCD'.
*    out->write( zcl_type_convertion=>do_something( CONV string( var ) ) ).

***********************************************************************************************************************************************

**    In-line Conversion:
*    DATA(result) = '20260328'.
*    out->write( result ).
*
*    DATA(result1) = CONV d( '20260328' ).  "Forced Conversion
*    out->write( result1 ).



*********************************************************************************************************************************

*    var_string = `R2D2`.
*    var_n = var_string.
*    out->write( var_n ).  " 'n' are numeric type and only takes numeric values. so. the two's will be accepted & the two 'Rs' will be replace with 0

**********************************************************************************************************************************

*    var_date = cl_abap_context_info=>get_system_date( ).
*    var_date = 'ABCDEFGH'.                 "output => ABCD-EF-GH ...
*    var_int = var_date.
*    out->write( var_date ).                "This will output an unexpected result of '737904'


***************************************************************************************************************************************


*    var_string1 = 'ABCDE'.   "
*    var_char   = var_string1.
*    out->write( var_char ).   " DE will be truncated, since the total length is 3. only ABD will be outputed




******************************************************************************************************************************************



*    var_string = 'ABCD'.
*    var_int = var_string.
*    out->write( var_int ). "ABCD cannot be interpreted as int -> exception error: CX_SY_CONVERSION_NO_NUMBER

*     TRY.
*        var_int = var_string.   " exception occurs here
*        out->write( |Wring convertion due to TYPE mismatch numberic-string/int: { var_int }| ).
*
*      CATCH cx_sy_conversion_no_number.
*        out->write( 'Source TYPE STRING for var_string is not compatible with target TYPE I for var_int' ).
*    ENDTRY.

********************************************************************************************************************************************

*    var_string = '123A45'.
*    var_string = 'ABCDEF'.
*    var_int = var_string.
*    out->write( var_int ). " 'var_int' it contains only not numeric value, an exception ' CX_SY_CONVERSION_NO_NUMBER' is thrown. Source TYPE not compatible with target TYPE


********************************************************************************************************************************************

*    var_string1 = '20260328'.
*    var_date   = var_string1.
*    out->write( var_date ).


*******************************************************************************************************************************************

**    var_string = '123'. "will also be executed without errors
*    var_int = 123.
*    var_pack   = var_int.
*    out->write( var_pack ).     "causes an arithmetic overflow and the system responds with the exception CX_SY_CONVERSION_OVERFLOW


  ENDMETHOD.


ENDCLASS.

