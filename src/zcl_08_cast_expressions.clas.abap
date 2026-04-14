CLASS zcl_08_cast_expressions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_cast_expressions IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/flight
        FIELDS DISTINCT
            carrier_id,
            connection_id,
            flight_date,
            seats_max,
            seats_occupied,
            seats_max - seats_occupied AS available_seats
        WHERE carrier_id = 'AA'
        ORDER BY seats_max - seats_occupied DESCENDING,
        flight_date                         ASCENDING
    INTO TABLE @DATA(lt_flight).


    out->write( lt_flight ).





**************************************************************************************************************

*    SELECT FROM /dmo/travel
*        FIELDS
*            begin_date,
*            end_date,
*            is_valid( begin_date )                   AS valid,
*
*            add_days( begin_date, 7 )                AS add_7_days,
*            add_months( begin_date, 3 )              AS add_3_months,
*            days_between( begin_date, end_date )     AS duration,
*
*            weekday( begin_date )                    AS weekday,
*            extract_month( begin_date )              AS month,
*            extract_year( begin_date )               AS year,
*            dayname( begin_date )                    AS day_name
*
*     WHERE days_between( begin_date, end_date ) > 10
*     INTO TABLE @DATA(lt_date).
*
*    out->write( lt_date ).


**************************************************************************************************************
*    "extract date using left(), right() and substring()
*    SELECT FROM /dmo/flight
*          FIELDS
*              flight_date,
*                  CAST( flight_date AS CHAR( 8 ) )      AS flight_date_raw,
*                  left( flight_date, 4 )                AS year,
*                  right( flight_date, 2 )               AS day,
*                  substring( flight_date, 5, 2 )        AS month
*
**                  year( flight_date )                   AS my_year,       " modern & recommended
**                  month( flight_date )                  AS my_month,      " modern & recommended
**                  day( flight_date )                    AS my_day         " modern & recommended
*
*
*    INTO TABLE @DATA(lt_result).
*
*    out->write( lt_result ).


***********************************************************************************************************************

**    String processing
*    SELECT FROM /dmo/customer
*            FIELDS
*                customer_id,
*                title && ' ' && first_name && ' ' && last_name          AS full_name,
**                street && ',' && ' ' && postal_code && ' ' && city      as address_expr        "This line of code do the same thing as the line below with 'concat()'
*
*                concat( street,
*                        concat_with_space( ',',
*                                            concat_with_space( postal_code, city, 1 ),
*                                            1  )
*                       ) AS address_function
*
*                INTO TABLE @DATA(lt_address).
*
*    out->write( lt_address ).


**************************************************************************************************************************

**  Converting INT input to FLOAT (FLTP) output using CAST, effect of DIV() and DIVISION() on INTEGERS
*    SELECT FROM /dmo/flight
*                FIELDS
*                seats_max,
*                seats_occupied,
*                seats_max - seats_occupied                    AS seats_avalable,
*                ( CAST( seats_occupied AS FLTP )
*                    * CAST( 100 AS FLTP ) )
*                    / CAST( seats_max AS FLTP )               AS percentage_fltp,
*
*                div( seats_occupied * 100 , seats_max )       as percentage_int,
*                division( seats_occupied * 100 , seats_max, 2 )    as percentage_dec
*
*    into table @DATA(lt_table). "creating internal table called lt_table using the @ sign, because we want to select multiple rows hence 'INTO TABLE'
*
*    out->write( lt_table ).



*  --------------------------------------------------------------------------------------------------------------------------------------


*        CASTING
*    SELECT
*         '20260403'                              AS char_8,         "not a CAST. It is a literal with an alias
*          CAST( '20260403' AS CHAR( 4 ) )        AS chr_4,          "Explicit CAST. Takes the first four character and discard the rest. result 2026
*          CAST( '20260403' AS CHAR( 8 ) )        AS num_8,          "Explicit CAST to 8 characters. result 20260403
*          CAST( '20260403' AS INT4 )             AS integer,        "Force conversion to to integer INT4 (which has up 10 digits). result 20260403
*          CAST( '20260403' AS DEC( 10, 2 ) )     AS dec_10_2,       "converted to packed decimal number with 10 total digits and 2 decimal places. result 20260403.0
*          CAST( '20260403' AS FLTP )             AS fltp,           "Convert to floating number. result 20260403.0 or 2.060403E7
*          CAST( '20260403' AS DATS )             AS date            "Convert the 8 character string to ABAO's date type YYYY-MM-DD. result 2026-04-03
*        FROM /dmo/carrier
*        INTO TABLE @DATA(lt_result).
*
*    out->write( lt_result ).

  ENDMETHOD.
ENDCLASS.









