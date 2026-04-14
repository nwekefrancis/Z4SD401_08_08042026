CLASS zcl_populate_airline_data DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_populate_airline_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DELETE FROM zcarrier_flight.   " Clear old data

    INSERT zcarrier_flight FROM TABLE @( VALUE #(
      ( carrier_id = 'LH'  carrier_name = 'Lufthansa'        connection_id = '0400'
        airport_from = 'FRA' airport_from_id = 'FRA' airport_from_name = 'Frankfurt Airport'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '850.00'  currency_code = 'EUR' )

      ( carrier_id = 'LH'  carrier_name = 'Lufthansa'        connection_id = '0401'
        airport_from = 'JFK' airport_from_id = 'JFK' airport_from_name = 'New York (JFK)'
        airport_to   = 'FRA' airport_to_id   = 'FRA' airport_to_name   = 'Frankfurt Airport'
        price = '920.00'  currency_code = 'EUR' )

      ( carrier_id = 'AF'  carrier_name = 'Air France'       connection_id = '1234'
        airport_from = 'CDG' airport_from_id = 'CDG' airport_from_name = 'Paris Charles de Gaulle'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '720.00'  currency_code = 'EUR' )

      ( carrier_id = 'AF'  carrier_name = 'Air France'       connection_id = '1235'
        airport_from = 'JFK' airport_from_id = 'JFK' airport_from_name = 'New York (JFK)'
        airport_to   = 'CDG' airport_to_id   = 'CDG' airport_to_name   = 'Paris Charles de Gaulle'
        price = '780.00'  currency_code = 'EUR' )

      ( carrier_id = 'AA'  carrier_name = 'American Airlines' connection_id = '0100'
        airport_from = 'JFK' airport_from_id = 'JFK' airport_from_name = 'New York (JFK)'
        airport_to   = 'LAX' airport_to_id   = 'LAX' airport_to_name   = 'Los Angeles'
        price = '420.00'  currency_code = 'USD' )

      ( carrier_id = 'BA'  carrier_name = 'British Airways'  connection_id = '0178'
        airport_from = 'LHR' airport_from_id = 'LHR' airport_from_name = 'London Heathrow'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '680.00'  currency_code = 'EUR' )

      ( carrier_id = 'JL'  carrier_name = 'Japan Airlines'   connection_id = '0406'
        airport_from = 'NRT' airport_from_id = 'NRT' airport_from_name = 'Tokyo Narita'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '1250.00' currency_code = 'USD' )   " or JPY if you prefer

      ( carrier_id = 'EK'  carrier_name = 'Emirates'         connection_id = '0001'
        airport_from = 'DXB' airport_from_id = 'DXB' airport_from_name = 'Dubai International'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '1100.00' currency_code = 'USD' )

      ( carrier_id = 'LH'  carrier_name = 'Lufthansa'        connection_id = '0402'
        airport_from = 'MUC' airport_from_id = 'MUC' airport_from_name = 'Munich Airport'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '780.00'  currency_code = 'EUR' )

      ( carrier_id = 'AA'  carrier_name = 'American Airlines' connection_id = '0101'
        airport_from = 'LAX' airport_from_id = 'LAX' airport_from_name = 'Los Angeles'
        airport_to   = 'JFK' airport_to_id   = 'JFK' airport_to_name   = 'New York (JFK)'
        price = '460.00'  currency_code = 'USD' )
    ) ).

    out->write( |Inserted { sy-dbcnt } flight records with currency_code successfully.| ).

  ENDMETHOD.
ENDCLASS.
