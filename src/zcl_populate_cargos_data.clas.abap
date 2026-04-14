CLASS zcl_populate_cargos_data DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_populate_cargos_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    SELECT * FROM zcargos_flight INTO TABLE @DATA(lt_cargo).
    out->write( lt_cargo ).

*    DELETE FROM zcargos_flight.   " Clear previous data
*
*    INSERT zcargos_flight FROM TABLE @( VALUE #(
*      " Lufthansa Cargo
*      ( carrier_id = 'LH'  carrier_name = 'Lufthansa Cargo'   connection_id = '0400'  flight_date = '20260325'
*        airport_from = 'FRA' airport_from_name = 'Frankfurt Airport'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '24500.500'  cargo_value = '1850000.00'  currency_code = 'EUR'  flight_status = 'A' )
*
*      ( carrier_id = 'LH'  carrier_name = 'Lufthansa Cargo'   connection_id = '0401'  flight_date = '20260326'
*        airport_from = 'JFK' airport_from_name = 'New York (JFK)'
*        airport_to   = 'FRA' airport_to_name   = 'Frankfurt Airport'
*        cargo_weight_kg = '31200.750'  cargo_value = '2450000.00'  currency_code = 'EUR'  flight_status = 'D' )
*
*      " Air France Cargo
*      ( carrier_id = 'AF'  carrier_name = 'Air France Cargo'  connection_id = '1234'  flight_date = '20260325'
*        airport_from = 'CDG' airport_from_name = 'Paris Charles de Gaulle'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '18900.000'  cargo_value = '980000.00'   currency_code = 'EUR'  flight_status = 'A' )
*
*      " American Airlines Cargo
*      ( carrier_id = 'AA'  carrier_name = 'American Cargo'    connection_id = '0100'  flight_date = '20260327'
*        airport_from = 'JFK' airport_from_name = 'New York (JFK)'
*        airport_to   = 'LAX' airport_to_name   = 'Los Angeles'
*        cargo_weight_kg = '15600.250'  cargo_value = '1250000.00'  currency_code = 'USD'  flight_status = 'D' )
*
*      ( carrier_id = 'AA'  carrier_name = 'American Cargo'    connection_id = '0101'  flight_date = '20260328'
*        airport_from = 'LAX' airport_from_name = 'Los Angeles'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '27800.000'  cargo_value = '2100000.00'  currency_code = 'USD'  flight_status = 'A' )
*
*      " Emirates Cargo
*      ( carrier_id = 'EK'  carrier_name = 'Emirates SkyCargo' connection_id = '0001'  flight_date = '20260325'
*        airport_from = 'DXB' airport_from_name = 'Dubai International'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '45200.900'  cargo_value = '3780000.00'  currency_code = 'USD'  flight_status = 'D' )
*
*      " Japan Airlines Cargo
*      ( carrier_id = 'JL'  carrier_name = 'Japan Airlines Cargo' connection_id = '0406'  flight_date = '20260329'
*        airport_from = 'NRT' airport_from_name = 'Tokyo Narita'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '16800.000'  cargo_value = '1450000.00'  currency_code = 'USD'  flight_status = 'A' )
*
*      " British Airways Cargo
*      ( carrier_id = 'BA'  carrier_name = 'British Airways Cargo' connection_id = '0178'  flight_date = '20260326'
*        airport_from = 'LHR' airport_from_name = 'London Heathrow'
*        airport_to   = 'JFK' airport_to_name   = 'New York (JFK)'
*        cargo_weight_kg = '22100.300'  cargo_value = '1650000.00'  currency_code = 'EUR'  flight_status = 'D' )
*    ) ).
*
*    out->write( |✅ Inserted { sy-dbcnt } cargo flight records successfully.| ).

  ENDMETHOD.
ENDCLASS.
