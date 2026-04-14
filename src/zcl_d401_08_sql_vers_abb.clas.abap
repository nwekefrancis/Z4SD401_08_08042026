CLASS zcl_d401_08_sql_vers_abb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d401_08_sql_vers_abb IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.

    DATA(lv_demo) =  lcl_demo=>summe( ).


*Kapitel 4 Lektion 2,3  Übung 11
*dats_add_days( date, days, on_error )
***Abb.88
*    DATA lv_demo_1 TYPE c LENGTH 20.
*    DATA ls_demo_1 TYPE /dmo/carrier.
*    DATA lv_demo_2 TYPE /dmo/carrier_id.
*    DATA lv_demo_3 TYPE string VALUE 'Ausgabe'.
*
*
**    SELECT SINGLE FROM /dmo/carrier FIELDS 'Demo-1' as a, 'Demo-2' as b  INTO @DATA(ls_result).
*    SELECT  FROM /dmo/carrier FIELDS  20 AS c,  'Demo-1' AS a, 'Demo-2' AS b, @lv_demo_3 AS demo_03,
*              @lv_demo AS demo4, carrier_id, name
**
**       WHERE carrier_id LIKE '%'  INTO TABLE @DATA(lt_result).
**       WHERE upper( carrier_id ) like '%'  INTO TABLE @DATA(lt_result).
*       WHERE upper( name ) LIKE 'AIR%'  INTO TABLE @DATA(lt_result).
**       WHERE  name  LIKE 'air%'  INTO TABLE @DATA(lt_result).
*
**    out->write( ls_result ).
*    out->write( data = lt_result
*                name = CONV string(  sy-dbcnt ) ).



**Abb.91
*
*    data lv_demo_01 type p LENGTH 3 DECIMALS 2.     "2*3-1  Anzahl der Stellen in der Variable 5 davon 2 Nachkommastellen
*     lv_demo_01 = '123.45'.
*
*
*
*    SELECT SINGLE FROM /dmo/connection FIELDS airport_from_id,
*       `Demo-1` AS demo_1, `Demo2` AS demo_2,  '123' && '567' AS kette,
*          CAST( '123456' AS CHAR( 3 )  ) as banane,
*          CAST( '123456' AS FLTP  ) AS birne,
*          CAST( '11234635.55' AS DEC( 10, 2 )  ) AS dec_info,
*          CAST( '123.45-' AS DEC( 6, 3 )  ) AS dec_info1,       "5 Stellen davon 3 Nachkommastellen 99,999  999,999
*          CAST( '123456' AS INT4  ) AS birne1
*
*           INTO @DATA(ls_demo).
*
*    out->write( ls_demo ).
*
*
*
*    RETURN.
**


**Abb.93

    DATA lv_demo1 TYPE c LENGTH 10.

    lv_demo1 = 'Mister'(001).
    lv_demo1 = TEXT-001.
    SELECT FROM /dmo/customer
           FIELDS customer_id, title,
                  CASE title
                    WHEN 'Mr.'  THEN @lv_demo1
                    WHEN 'Mrs.' THEN 'Misses'
                    ELSE             ' '
                 END AS title_long

           WHERE country_code = 'AT'
            INTO TABLE @DATA(result_simple).

    out->write(
      EXPORTING
        data   = result_simple
        name   = 'Simple Case Distinction'
    ).


    RETURN.






***Abb.94
* out->write(  `-----------------------------------------------` ).
**
*    SELECT FROM /dmo/flight
*         FIELDS flight_date,
*                seats_max,
*                seats_occupied,
*                CASE
*                  WHEN seats_occupied < seats_max THEN 'Seats Avaliable'
*                  WHEN seats_occupied = seats_max THEN 'Fully Booked'
*                  WHEN seats_occupied > seats_max THEN 'Overbooked!'
*                  ELSE                                 'This is impossible'
*                END AS booking_state
*          WHERE carrier_id    = 'LH'
*            AND connection_id = '0400'
*           INTO TABLE @DATA(result_complex).
*
*    out->write(
*      EXPORTING
*        data   = result_complex
*        name   = 'Complex Case Distinction'
*    ).
***
*
*return.

**Abb.96
*    SELECT FROM /dmo/flight
*            FIELDS seats_max,
*                   seats_occupied,
*                   seats_max - seats_occupied           AS seats_avaliable,
*
*                  CAST(
*                   (   CAST( seats_occupied AS FLTP )
*                     * CAST( 100 AS FLTP )
*                   ) / CAST(  seats_max AS FLTP ) AS DEC( 10,2 ) )     AS percentage_dec,
*
*
*                   (   CAST( seats_occupied AS FLTP )
*                     * CAST( 100 AS FLTP )
*                   ) / CAST(  seats_max AS FLTP )      AS percentage_fltp
*
*              WHERE carrier_id = 'LH'
*               INTO TABLE @DATA(result).
*    out->write( data   = result name   = 'RESULT' ).
*
*    DATA lv_dec TYPE p DECIMALS 2.
*    LOOP AT result ASSIGNING FIELD-SYMBOL(<fs>).
*      lv_dec = <fs>-percentage_fltp.
*      out->write( lv_dec ).
*    ENDLOOP.
*
*
*
*
**    DATA lv_dec TYPE p DECIMALS 2.
*    LOOP AT result ASSIGNING FIELD-SYMBOL(<fs1>).
*      lv_dec = <fs1>-percentage_fltp.
*      out->write( | { <fs1>-seats_max } { <fs1>-seats_occupied } { <fs1>-seats_avaliable }  { lv_dec NUMBER = ENVIRONMENT  }  |    ).
*    ENDLOOP.
**
*
*
*    RETURN.

**Abb.97
*    SELECT FROM /dmo/flight
*             FIELDS seats_max,
*                    seats_occupied,
*
*                    (   CAST( seats_occupied AS FLTP )
*                      * CAST( 100 AS FLTP )
*                    ) / CAST(  seats_max AS FLTP )                  AS percentage_fltp,
*
*                    div( seats_occupied * 100 , seats_max )         AS percentage_int,
*
*                    division(  seats_occupied * 100, seats_max, 2 ) AS percentage_dec
*
*              WHERE carrier_id    = 'LH'
*               INTO TABLE @DATA(result).
*
*    out->write(
*      EXPORTING
*        data   = result
*        name   = 'RESULT'
*    ).
*
*    RETURN.


**Abb.101
*SELECT FROM /dmo/customer
*         FIELDS customer_id,
*                street && ',' && ' '  && postal_code && ' ' && city   AS address_expr,
*
*                concat( street,
*                        concat_with_space(  ',',
*                                             concat_with_space( postal_code,
*                                                                upper(  city ),
*                                                                1
*                                                              ),
*                                            1
*                                         )
*                     ) AS address_func
*
*          WHERE country_code = 'ES'
*           INTO TABLE @DATA(result_concat).
*
*    out->write(
*      EXPORTING
*        data   = result_concat
*        name   = 'Concatenation'
*    ).
**
***********************************************************************
*out->write(  `-------------------------------------------------------------------------` ).

**Abb.102
*    SELECT FROM /dmo/carrier
*         FIELDS carrier_id,
*                name,
*                upper( name )   AS name_upper,
*                lower( name )   AS name_lower,
*                initcap( name ) AS name_initcap
*
**          WHERE carrier_id = 'SR'
*           INTO TABLE @DATA(result_transform).
*
*    out->write(
*      EXPORTING
*        data   = result_transform
*        name   = 'Uppercase/Lowercase'
*    ).

***********************************************************************

*out->write(  `-------------------------------------------------------------------------` ).

**Abb.103

*    SELECT FROM /dmo/flight
*         FIELDS flight_date,
*                CAST( flight_date AS CHAR( 8 ) )  AS flight_date_raw,
*
*                left(      flight_date, 4    ) AS year,
*                right(     flight_date, 2    ) AS day,
*                substring( flight_date, 5, 2 ) AS month
*
*          WHERE carrier_id = 'LH'
*            AND connection_id = '0400'
*           INTO TABLE @DATA(result_substring).
*
*    out->write(
*      EXPORTING
*        data   = result_substring
*        name   = 'Substring extraction'
*    ).



  ENDMETHOD.
ENDCLASS.
