*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

"! <p class="shorttext synchronized">Abstract base class for all vehicles</p>
"! This mother class contains the common attributes shared by trucks and buses.
"! It also provides helper methods to expose the common vehicle data.
CLASS lcl_vehicle DEFINITION ABSTRACT.

  PUBLIC SECTION.

    "! Type for vehicle price
    TYPES ty_price TYPE p LENGTH 8 DECIMALS 2.

    "! <p class="shorttext synchronized">Constructor for a vehicle</p>
    "! @parameter iv_make  | Vehicle manufacturer / brand
    "! @parameter iv_model | Vehicle model name
    "! @parameter iv_price | Vehicle price
    "! @parameter iv_color | Vehicle colour
    METHODS constructor
      IMPORTING
        iv_make  TYPE string
        iv_model TYPE string
        iv_price TYPE ty_price
        iv_color TYPE string.

    "! Structure for common vehicle data
    TYPES: BEGIN OF ty_vehicle_data,
             make  TYPE string,
             model TYPE string,
             price TYPE ty_price,
             color TYPE string,
           END OF ty_vehicle_data.

    "! <p class="shorttext synchronized">Returns common vehicle data</p>
    "! @parameter rs_data | Structure containing make, model, price and colour
    METHODS get_vehicle_data
      RETURNING VALUE(rs_data) TYPE ty_vehicle_data.

    "! <p class="shorttext synchronized">Displays the common vehicle attributes</p>
    "! @parameter out | ADT console output object
    METHODS display_attributes
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.

  PRIVATE SECTION.

    "! Manufacturer / brand of the vehicle
    DATA mv_make TYPE string.

    "! Model of the vehicle
    DATA mv_model TYPE string.

    "! Price of the vehicle
    DATA mv_price TYPE ty_price.

    "! Color of the vehicle
    DATA mv_color TYPE string.

ENDCLASS.



CLASS lcl_vehicle IMPLEMENTATION.

  METHOD constructor.
    " Store constructor input values in the object attributes
    mv_make  = iv_make.
    mv_model = iv_model.
    mv_price = iv_price.
    mv_color = iv_color.
  ENDMETHOD.

  METHOD get_vehicle_data.
    " Return the common mother-class data as one structure
    rs_data-make  = mv_make.
    rs_data-model = mv_model.
    rs_data-price = mv_price.
    rs_data-color = mv_color.
  ENDMETHOD.

  METHOD display_attributes.
    " Generic output for all vehicles
    out->write(
      |Make: { mv_make }, Model: { mv_model }, Price: { mv_price }, Color: { mv_color }| ).
  ENDMETHOD.

ENDCLASS.



"! <p class="shorttext synchronized">Subclass for trucks</p>
"! This class inherits from lcl_vehicle and adds the truck-specific
"! attribute cargo capacity.
CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Constructor for a truck</p>
    "! @parameter iv_make  | Truck manufacturer / brand
    "! @parameter iv_model | Truck model name
    "! @parameter iv_price | Truck price
    "! @parameter iv_color | Truck colour
    "! @parameter iv_cargo | Cargo capacity in tons
    METHODS constructor
      IMPORTING
        iv_make  TYPE string
        iv_model TYPE string
        iv_price TYPE lcl_vehicle=>ty_price
        iv_color TYPE string
        iv_cargo TYPE i.

    "! <p class="shorttext synchronised">Displays truck attributes</p>
    "! @parameter out | ADT console output object
    METHODS display_attributes REDEFINITION.

    "! <p class="shorttext synchronized">Returns cargo capacity</p>
    "! @parameter rv_cargo | Cargo capacity in tons
    METHODS get_cargo
      RETURNING VALUE(rv_cargo) TYPE i.

    "! <p class="shorttext synchronized">Returns maximum cargo capacity</p>
    "! This method exists to match the assignment wording.
    "! @parameter rv_cargo | Maximum cargo capacity in tons
    METHODS get_max_cargo
      RETURNING VALUE(rv_cargo) TYPE i.

  PRIVATE SECTION.

    "! Cargo capacity of the truck in tons
    DATA mv_cargo TYPE i.

ENDCLASS.



CLASS lcl_truck IMPLEMENTATION.

  METHOD constructor.
    " First initialize the inherited common vehicle attributes
    super->constructor(
      iv_make  = iv_make
      iv_model = iv_model
      iv_price = iv_price
      iv_color = iv_color ).

    " Then initialize the truck-specific attribute
    mv_cargo = iv_cargo.
  ENDMETHOD.

  METHOD display_attributes.
    " Reuse the generic output from the mother class
    super->display_attributes( out = out ).

    " Add truck-specific information
    out->write( |Cargo capacity: { mv_cargo } t| ).
  ENDMETHOD.

  METHOD get_cargo.
    rv_cargo = mv_cargo.
  ENDMETHOD.

  METHOD get_max_cargo.
    rv_cargo = mv_cargo.
  ENDMETHOD.

ENDCLASS.



"! <p class="shorttext synchronized">Subclass for buses</p>
"! This class inherits from lcl_vehicle and adds the bus-specific
"! attribute number of seats.
CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Constructor for a bus</p>
    "! @parameter iv_make  | Bus manufacturer / brand
    "! @parameter iv_model | Bus model name
    "! @parameter iv_price | Bus price
    "! @parameter iv_color | Bus colour
    "! @parameter iv_seats | Number of seats
    METHODS constructor
      IMPORTING
        iv_make  TYPE string
        iv_model TYPE string
        iv_price TYPE lcl_vehicle=>ty_price
        iv_color TYPE string
        iv_seats TYPE i.

    "! <p class="shorttext synchronized">Displays bus attributes</p>
    "! @parameter out | ADT console output object
    METHODS display_attributes REDEFINITION.

    "! <p class="shorttext synchronized">Returns the number of seats</p>
    "! @parameter rv_seats | Number of seats
    METHODS get_seats
      RETURNING VALUE(rv_seats) TYPE i.

  PRIVATE SECTION.

    "! Number of seats of the bus
    DATA mv_seats TYPE i.

ENDCLASS.



CLASS lcl_bus IMPLEMENTATION.

  METHOD constructor.
    " First initialize the inherited common vehicle attributes
    super->constructor(
      iv_make  = iv_make
      iv_model = iv_model
      iv_price = iv_price
      iv_color = iv_color ).

    " Then initialize the bus-specific attribute
    mv_seats = iv_seats.
  ENDMETHOD.

  METHOD display_attributes.
    " Reuse the generic output from the mother class
    super->display_attributes( out = out ).

    " Add bus-specific information
    out->write( |Seats: { mv_seats }| ).
  ENDMETHOD.

  METHOD get_seats.
    rv_seats = mv_seats.
  ENDMETHOD.

ENDCLASS.



"! <p class="shorttext synchronized">Rental manager class</p>
"! This class stores all vehicles in a collection of references to the
"! mother class lcl_vehicle. It also provides filtering, search,
"! downcasting, and table-building logic for the assignment output.
CLASS lcl_rental DEFINITION.

  PUBLIC SECTION.

    "! Table type for all vehicle references
    TYPES tt_vehicles TYPE STANDARD TABLE OF REF TO lcl_vehicle WITH EMPTY KEY.

    "! Output row type for truck tables
    TYPES: BEGIN OF ty_truck_row,
             make           TYPE string,
             model          TYPE string,
             price          TYPE lcl_vehicle=>ty_price,
             color          TYPE string,
             cargo_capacity TYPE i,
           END OF ty_truck_row.

    "! Table type for truck output
    TYPES tt_truck_rows TYPE STANDARD TABLE OF ty_truck_row WITH EMPTY KEY.

    "! Output row type for bus tables
    TYPES: BEGIN OF ty_bus_row,
             make  TYPE string,
             model TYPE string,
             price TYPE lcl_vehicle=>ty_price,
             color TYPE string,
             seats TYPE i,
           END OF ty_bus_row.

    "! Table type for bus output
    TYPES tt_bus_rows TYPE STANDARD TABLE OF ty_bus_row WITH EMPTY KEY.

    "! <p class="shorttext synchronized">Adds one vehicle reference</p>
    "! @parameter io_vehicle | Reference to a vehicle object
    METHODS add_vehicle
      IMPORTING
        io_vehicle TYPE REF TO lcl_vehicle.

    "! <p class="shorttext synchronized">Returns all trucks in table form</p>
    "! @parameter rt_trucks | Internal table with all trucks
    METHODS get_trucks_table
      RETURNING VALUE(rt_trucks) TYPE tt_truck_rows.

    "! <p class="shorttext synchronized">Returns all buses in table form</p>
    "! @parameter rt_buses | Internal table with all buses
    METHODS get_buses_table
      RETURNING VALUE(rt_buses) TYPE tt_bus_rows.

    "! <p class="shorttext synchronized">Finds truck with maximum cargo capacity</p>
    "! This method solves assignment task 4 using downcasting.
    "! @parameter ro_truck | Reference to the truck with the highest cargo capacity
    METHODS get_max_cargo_truck
      RETURNING VALUE(ro_truck) TYPE REF TO lcl_truck.

    "! <p class="shorttext synchronized">Returns the max-cargo truck as one-row table</p>
    "! @parameter rt_trucks | Internal table containing the truck with maximum cargo capacity
    METHODS get_max_truck_table
      RETURNING VALUE(rt_trucks) TYPE tt_truck_rows.

    "! <p class="shorttext synchronized">Returns all trucks below 2 tons as table</p>
    "! @parameter rt_trucks | Internal table with trucks whose cargo capacity is below 2 tons
    METHODS get_small_trucks_table
      RETURNING VALUE(rt_trucks) TYPE tt_truck_rows.

    "! <p class="shorttext synchronized">Checks whether small trucks exist</p>
    "! Raises the custom exception if at least one truck has less than 2 tons.
    METHODS check_small_trucks
      RAISING zcx_d401_08_failed.

    "! <p class="shorttext synchronized">Constructor for rental company</p>
    "! @parameter iv_rental_name | Name of the rental company
    METHODS constructor
      IMPORTING
        iv_rental_name TYPE string.

    "! <p class="shorttext synchronized">Returns the rental company name</p>
    "! @parameter rv_name | Name of the rental company
    METHODS get_rental_name
      RETURNING VALUE(rv_name) TYPE string.

  PRIVATE SECTION.

    "! Internal collection of all vehicles
    DATA mt_vehicles TYPE tt_vehicles.

    "! Name of the rental company
    DATA mv_rental_name TYPE string.


ENDCLASS.



CLASS lcl_rental IMPLEMENTATION.

  METHOD constructor.
    mv_rental_name = iv_rental_name.
  ENDMETHOD.

  METHOD get_rental_name.
    rv_name = mv_rental_name.
  ENDMETHOD.


  METHOD add_vehicle.
    " Store one vehicle reference in the rental collection
    APPEND io_vehicle TO mt_vehicles.
  ENDMETHOD.

  METHOD get_trucks_table.
    " Loop over all vehicles and keep only trucks
    LOOP AT mt_vehicles INTO DATA(lo_vehicle).
      TRY.
          " Downcast from vehicle reference to truck reference
          DATA(lo_truck) = CAST lcl_truck( lo_vehicle ).
          DATA(ls_vehicle_data) = lo_truck->get_vehicle_data( ).

          " Add one truck row to the output table
          APPEND VALUE ty_truck_row(
            make           = ls_vehicle_data-make
            model          = ls_vehicle_data-model
            price          = ls_vehicle_data-price
            color          = ls_vehicle_data-color
            cargo_capacity = lo_truck->get_cargo( )
          ) TO rt_trucks.

        CATCH cx_sy_move_cast_error.
          " Ignore buses
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_buses_table.
    " Loop over all vehicles and keep only buses
    LOOP AT mt_vehicles INTO DATA(lo_vehicle).
      TRY.
          " Downcast from vehicle reference to bus reference
          DATA(lo_bus) = CAST lcl_bus( lo_vehicle ).
          DATA(ls_vehicle_data) = lo_bus->get_vehicle_data( ).

          " Add one bus row to the output table
          APPEND VALUE ty_bus_row(
            make  = ls_vehicle_data-make
            model = ls_vehicle_data-model
            price = ls_vehicle_data-price
            color = ls_vehicle_data-color
            seats = lo_bus->get_seats( )
          ) TO rt_buses.

        CATCH cx_sy_move_cast_error.
          " Ignore trucks
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_max_cargo_truck.
    DATA lv_max_cargo TYPE i VALUE 0.

    " Loop over all vehicles and compare truck cargo capacity
    LOOP AT mt_vehicles INTO DATA(lo_vehicle).
      TRY.
          " Downcast to truck
          DATA(lo_truck) = CAST lcl_truck( lo_vehicle ).

          " Keep the truck with the highest cargo capacity
          IF lo_truck->get_max_cargo( ) > lv_max_cargo.
            lv_max_cargo = lo_truck->get_max_cargo( ).
            ro_truck = lo_truck.
          ENDIF.

        CATCH cx_sy_move_cast_error.
          " Ignore non-truck objects
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_max_truck_table.
    " Reuse the search method and convert the result to a one-row table
    DATA(lo_max_truck) = get_max_cargo_truck( ).

    IF lo_max_truck IS BOUND.
      DATA(ls_vehicle_data) = lo_max_truck->get_vehicle_data( ).

      APPEND VALUE ty_truck_row(
        make           = ls_vehicle_data-make
        model          = ls_vehicle_data-model
        price          = ls_vehicle_data-price
        color          = ls_vehicle_data-color
        cargo_capacity = lo_max_truck->get_cargo( )
      ) TO rt_trucks.
    ENDIF.
  ENDMETHOD.

  METHOD get_small_trucks_table.
    " Loop over all vehicles and collect all trucks below 2 tons
    LOOP AT mt_vehicles INTO DATA(lo_vehicle).
      TRY.
          DATA(lo_truck) = CAST lcl_truck( lo_vehicle ).

          IF lo_truck->get_cargo( ) < 2.
            DATA(ls_vehicle_data) = lo_truck->get_vehicle_data( ).

            APPEND VALUE ty_truck_row(
              make           = ls_vehicle_data-make
              model          = ls_vehicle_data-model
              price          = ls_vehicle_data-price
              color          = ls_vehicle_data-color
              cargo_capacity = lo_truck->get_cargo( )
            ) TO rt_trucks.
          ENDIF.

        CATCH cx_sy_move_cast_error.
          " Ignore buses
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD check_small_trucks.
    DATA lv_found       TYPE abap_bool VALUE abap_false.
    DATA lv_first_make  TYPE string.
    DATA lv_first_model TYPE string.
    DATA lv_first_cargo TYPE string.

    " Loop over all vehicles and detect the first truck below 2 tons.
    " The exception message will use its values as message placeholders.
    LOOP AT mt_vehicles INTO DATA(lo_vehicle).
      TRY.
          DATA(lo_truck) = CAST lcl_truck( lo_vehicle ).

          IF lo_truck->get_cargo( ) < 2.
            DATA(ls_vehicle_data) = lo_truck->get_vehicle_data( ).

            lv_found       = abap_true.
            lv_first_make  = ls_vehicle_data-make.
            lv_first_model = ls_vehicle_data-model.
            lv_first_cargo = |{ lo_truck->get_cargo( ) }|.

            EXIT.
          ENDIF.

        CATCH cx_sy_move_cast_error.
          " Ignore buses
      ENDTRY.
    ENDLOOP.

    " Raise the custom exception with T100 message mapping
    IF lv_found = abap_true.
      RAISE EXCEPTION TYPE zcx_d401_08_failed
        EXPORTING
          textid     = zcx_d401_08_failed=>truck_too_small
          make       = lv_first_make
          model      = lv_first_model
          cargo_text = lv_first_cargo.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
