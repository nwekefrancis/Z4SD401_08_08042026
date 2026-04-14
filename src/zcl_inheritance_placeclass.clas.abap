CLASS zcl_inheritance_placeclass DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_inheritance_placeclass IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( '=== Private Attributes in Inherited Demo ===' ).
    out->write( '.' ).

    " Create Passenger Plane object
    DATA(lo_passenger) = NEW lcl_passenger_plane(
                           iv_manufacturer = 'Boeing'
                           iv_type         = '747.800'
                           iv_seats        = 410 ).

    " === This is the missing part ===
    out->write( 'Passenger Plane Information:' ).
    lo_passenger->display_info( out ).        " ← Now it will print the data!

    out->write( '' ).
    out->write( '=== Note ===' ).
    out->write( 'Direct access to private attributes (manufacturer & type) from subclass is not possible.' ).

  ENDMETHOD.

ENDCLASS.
