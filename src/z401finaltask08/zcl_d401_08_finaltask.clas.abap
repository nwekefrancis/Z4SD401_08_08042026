"! <p class="shorttext synchronized">Main class for final task 08</p>
"! This class is the executable entry point of the application.
"! It creates the rental object, creates trucks and buses,
"! and outputs the required task results in tabular form.
CLASS zcl_d401_08_finaltask DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! Interface for console execution in ABAP Development Tools (ADT)
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS zcl_d401_08_finaltask IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Create the rental company object.
    " This object stores all vehicle references and performs the task logic.
    DATA(lo_rental) = NEW lcl_rental(
        iv_rental_name = 'NwekeDrive Rentals' ).

    out->write( |Rental company: { lo_rental->get_rental_name( ) }| ).
    out->write( ' ' ).

    " ----------------------------------------------------------------
    " Create 5 trucks
    " Each NEW lcl_truck( ) automatically calls:
    " 1. lcl_truck->constructor
    " 2. inside it, super->constructor of lcl_vehicle
    " ----------------------------------------------------------------
    lo_rental->add_vehicle(
      NEW lcl_truck(
        iv_make  = 'MAN'
        iv_model = 'TGL'
        iv_price = '85000.00'
        iv_color = 'White'
        iv_cargo = 1 ) ).

    lo_rental->add_vehicle(
      NEW lcl_truck(
        iv_make  = 'Mercedes'
        iv_model = 'Actros'
        iv_price = '120000.00'
        iv_color = 'Blue'
        iv_cargo = 3 ) ).

    lo_rental->add_vehicle(
      NEW lcl_truck(
        iv_make  = 'Volvo'
        iv_model = 'FH16'
        iv_price = '150000.00'
        iv_color = 'Black'
        iv_cargo = 6 ) ).

    lo_rental->add_vehicle(
      NEW lcl_truck(
        iv_make  = 'Scania'
        iv_model = 'R450'
        iv_price = '145000.00'
        iv_color = 'Red'
        iv_cargo = 8 ) ).

    lo_rental->add_vehicle(
      NEW lcl_truck(
        iv_make  = 'DAF'
        iv_model = 'XF'
        iv_price = '118000.00'
        iv_color = 'Silver'
        iv_cargo = 2 ) ).

    " ----------------------------------------------------------------
    " Create 5 buses
    " ----------------------------------------------------------------
    lo_rental->add_vehicle(
      NEW lcl_bus(
        iv_make  = 'Mercedes'
        iv_model = 'Citaro'
        iv_price = '210000.00'
        iv_color = 'Yellow'
        iv_seats = 40 ) ).

    lo_rental->add_vehicle(
      NEW lcl_bus(
        iv_make  = 'MAN'
        iv_model = 'Lions City'
        iv_price = '220000.00'
        iv_color = 'White'
        iv_seats = 45 ) ).

    lo_rental->add_vehicle(
      NEW lcl_bus(
        iv_make  = 'Volvo'
        iv_model = '7900'
        iv_price = '230000.00'
        iv_color = 'Blue'
        iv_seats = 42 ) ).

    lo_rental->add_vehicle(
      NEW lcl_bus(
        iv_make  = 'Setra'
        iv_model = 'S 515 HD'
        iv_price = '250000.00'
        iv_color = 'Grey'
        iv_seats = 50 ) ).

    lo_rental->add_vehicle(
      NEW lcl_bus(
        iv_make  = 'Iveco'
        iv_model = 'Crossway'
        iv_price = '205000.00'
        iv_color = 'Green'
        iv_seats = 38 ) ).

    " Output all trucks in tabular form
    out->write( '--- Truck table ---' ).
    out->write( data = lo_rental->get_trucks_table( ) ).

    out->write( ' ' ).

    " Output all buses in tabular form
    out->write( '--- Bus table ---' ).
    out->write( data = lo_rental->get_buses_table( ) ).

    out->write( ' ' ).

    " ----------------------------------------------------------------
    " Task 4:
    " Determine the truck with the maximum cargo capacity
    " and output it in tabular form
    " ----------------------------------------------------------------
    out->write( '--- Truck with maximum cargo capacity ---' ).
    out->write( data = lo_rental->get_max_truck_table( ) ).

    out->write( ' ' ).

    " ----------------------------------------------------------------
    " Task 5:
    " Check whether there are trucks with less than 2 tons.
    " If yes, the exception is raised and the affected trucks
    " are shown in tabular form.
    " ----------------------------------------------------------------
    out->write( '--- Trucks with less than 2 tons ---' ).

    TRY.
        lo_rental->check_small_trucks( ).
      CATCH zcx_d401_08_failed INTO DATA(lx_failed).
        out->write( lx_failed->get_text( ) ).
        out->write( data = lo_rental->get_small_trucks_table( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
