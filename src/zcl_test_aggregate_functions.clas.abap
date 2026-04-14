CLASS zcl_test_aggregate_functions DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_aggregate_functions IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( '=== AGGREGATE FUNCTIONS TEST ON TABLE ZCARRIER_FLIGHT ===' ).
    out->write( '----------------------------------------------------------' ).

    "================================================================
    " 1. COUNT(*) - Total number of flights
    "================================================================
    SELECT COUNT( * ) AS total_flights
      FROM zcarrier_flight
      INTO @DATA(lv_total_flights).

    out->write( |1. COUNT(*)   → Total number of flights: { lv_total_flights }| ).
    out->write( '' ).

    "================================================================
    " 2. COUNT(DISTINCT ...) - How many different airlines?
    "================================================================
    SELECT COUNT( DISTINCT carrier_id ) AS distinct_airlines
      FROM zcarrier_flight
      INTO @DATA(lv_distinct_airlines).

    out->write( |2. COUNT(DISTINCT carrier_id) → Different airlines: { lv_distinct_airlines }| ).
    out->write( '' ).

    "================================================================
    " 3. SUM() - Total revenue from all flights
    "================================================================
    SELECT SUM( price ) AS total_revenue
      FROM zcarrier_flight
      INTO @DATA(lv_total_revenue).

    out->write( |3. SUM(price)  → Total revenue from all flights: { lv_total_revenue } EUR| ).
    out->write( '' ).

    "================================================================
    " 4. AVG() - Average ticket price
    "================================================================
    SELECT AVG( price ) AS average_price
      FROM zcarrier_flight
      INTO @DATA(lv_avg_price).

    out->write( |4. AVG(price)  → Average ticket price: { lv_avg_price } EUR| ).
    out->write( '' ).

    "================================================================
    " 5. MIN() & MAX() - Cheapest and most expensive flight
    "================================================================
    SELECT MIN( price ) AS cheapest,
           MAX( price ) AS most_expensive
      FROM zcarrier_flight
      INTO @DATA(ls_min_max).

    out->write( |5. MIN(price)  → Cheapest flight : { ls_min_max-cheapest } EUR| ).
    out->write( |   MAX(price)  → Most expensive : { ls_min_max-most_expensive } EUR| ).
    out->write( '' ).

    "================================================================
    " 6. GROUP BY - Aggregates per airline (most useful!)
    "================================================================
    out->write( '6. GROUP BY carrier - All aggregates per airline:' ).

    SELECT carrier_id,
           carrier_name,
           COUNT( * )                      AS number_of_flights,
           COUNT( DISTINCT connection_id ) AS distinct_routes,
           SUM( price )                    AS total_revenue,
           AVG( price )                    AS avg_price,
           MIN( price )                    AS lowest_price,
           MAX( price )                    AS highest_price
      FROM zcarrier_flight
      GROUP BY carrier_id, carrier_name
      ORDER BY total_revenue DESCENDING          " <-- fixed: DESCENDING (not DESC)
      INTO TABLE @DATA(lt_group_by_carrier).

    out->write( lt_group_by_carrier ).
    out->write( '' ).

    "================================================================
    " 7. GROUP BY + HAVING - Only airlines with total revenue > 2000
    "================================================================
    out->write( '7. GROUP BY + HAVING (only airlines earning more than 2000 EUR):' ).

    SELECT carrier_name,
           SUM( price ) AS total_revenue,
           COUNT( * )   AS flight_count
      FROM zcarrier_flight
      GROUP BY carrier_name
      HAVING SUM( price ) > 2000
      INTO TABLE @DATA(lt_having).

    out->write( lt_having ).

    out->write( '----------------------------------------------------------' ).
    out->write( '✅ All aggregate functions tested successfully!' ).

  ENDMETHOD.
ENDCLASS.
