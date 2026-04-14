CLASS zcl_unit_5_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_unit_5_internal_table IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connections TYPE STANDARD TABLE OF /dmo/connection
                        WITH NON-UNIQUE KEY carrier_id connection_id.
    DATA my_connections TYPE STANDARD TABLE OF /dmo/connection.
    DATA wa_connections TYPE /dmo/connection.


    SELECT * FROM /dmo/connection
        WHERE carrier_id IN ( 'AA', 'LH', 'JL', 'QF', 'SQ' )
            INTO CORRESPONDING FIELDS OF TABLE @connections.

    LOOP AT connections INTO wa_connections.
        APPEND wa_connections TO my_connections.
    ENDLOOP.

    SORT my_connections BY carrier_id ASCENDING
                        connection_id DESCENDING.

    out->write( my_connections ).



**********************************************************************************************************************
* Pointer

*    DATA my_obj TYPE i VALUE 2.
*    DATA ptr       TYPE REF TO i.     " This is a pointer (reference)
*
*    ptr = REF #( my_obj ).          " ptr now points to my_object
*
*    out->write( ptr->* ).


**************************************************************************************************************************
*
*
*
*    " 1. Declare the source table (connections)
*    DATA connections TYPE STANDARD TABLE OF /dmo/connection.   " ← Adjust type if needed
*
*    " 2. Declare the target table (flights)
*    DATA flights TYPE STANDARD TABLE OF /dmo/connection
*                 WITH NON-UNIQUE KEY carrier_id connection_id.
*
*    DATA sum TYPE i.
*
*    " 3. Fill the 'connections' table first (example)
*    connections = VALUE #(
*      ( carrier_id     = 'AA' connection_id  = '0015' airport_from_id = 'JFK' airport_to_id   = 'LAX'
*                        departure_time = '140000'  arrival_time   = '180000'  distance  = 4000  distance_unit  = 'KM' )
*
*      ( carrier_id     = 'JL' connection_id  = '0401' airport_from_id = 'NRT' airport_to_id   = 'HND'
*                        departure_time = '090000' arrival_time   = '100000'   distance = 300    distance_unit  = 'KM' )
*
*      ( carrier_id     = 'SQ' connection_id  = '0001' airport_from_id = 'SIN' airport_to_id   = 'LHR'
*                        departure_time = '230000' arrival_time   = '060000'    distance = 10800  distance_unit  = 'KM' )
*    ).
*
*    " 4. Now copy using FOR line IN (Correct way)
*    flights = VALUE #( FOR line IN connections
*                       (
*                            carrier_id      = line-carrier_id
*                            connection_id   = line-connection_id
*                            airport_from_id = line-airport_from_id
*                            airport_to_id   = line-airport_to_id
*                            departure_time  = line-departure_time
*                            arrival_time    = line-arrival_time
*                            distance        = line-distance
*                            distance_unit   = line-distance_unit )
*
*                     ).
*
*    sum = REDUCE #( INIT total = 0
*                    FOR line IN flights
*                    NEXT total += line-distance ).
*
*    " 5. Output
*    out->write( flights ).
*    out->write( |Sum of the distances = { sum }| ).


**********************************************************************************************************

*    DATA flights TYPE STANDARD TABLE OF /dmo/flight
*                 WITH NON-UNIQUE KEY carrier_id
*                                     connection_id
*                                     flight_date.
*
*    SELECT FROM /dmo/flight
*      FIELDS client,
*             carrier_id,
*             connection_id,
*             flight_date,
*             price,
*             currency_code,
*             plane_type_id,
*             seats_max,
*             seats_occupied
*      WHERE carrier_id IN ( 'JL', 'AA', 'SQ', 'LH' )
*      INTO CORRESPONDING FIELDS OF TABLE @flights.
*    SORT flights BY carrier_id connection_id flight_date DESCENDING.
*    DELETE ADJACENT DUPLICATES FROM flights COMPARING carrier_id connection_id.     "deleting adjacent have to use 'COMPARING' to be able to delete...
*                                                                                    " COMPARING can have any number of key, but you have must have sorted the table.
*    out->write( flights ).



  ENDMETHOD.
ENDCLASS.








