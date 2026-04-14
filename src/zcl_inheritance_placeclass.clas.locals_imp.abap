*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_plane DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_manufacturer TYPE string
                            iv_type         TYPE string,
      display_info IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

  PRIVATE SECTION.
    DATA: manufacturer TYPE string,
          !type        TYPE string.
ENDCLASS.

CLASS lcl_plane IMPLEMENTATION.
  METHOD constructor.
    manufacturer = iv_manufacturer.
    !type        = iv_type.
  ENDMETHOD.

  METHOD display_info.
    io_out->write( |Manufacturer: { manufacturer }| ).
    io_out->write( |Type:         { !type }| ).
  ENDMETHOD.
ENDCLASS.


CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_plane.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_manufacturer TYPE string
                            iv_type         TYPE string
                            iv_seats        TYPE i,
      display_info REDEFINITION.

  PRIVATE SECTION.
    DATA seats TYPE i.
ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_manufacturer = iv_manufacturer
                        iv_type         = iv_type ).

    seats = iv_seats.
  ENDMETHOD.

  METHOD display_info.
    super->display_info( io_out ).           " Calls superclass → prints private attributes

    io_out->write( |Number of seats: { seats }| ).
  ENDMETHOD.
ENDCLASS.
