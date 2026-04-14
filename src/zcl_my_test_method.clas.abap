CLASS zcl_my_test_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      set_name IMPORTING imp_name TYPE string,
      get_name RETURNING VALUE(ret_name) TYPE string.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_name TYPE string.
ENDCLASS.

**********************************************************************
CLASS zcl_my_test_method IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_obj) = NEW zcl_my_test_method( ).

    lo_obj->set_name( 'Hugo' ).
    DATA(lv_name) = lo_obj->get_name( ).

    out->write( lv_name ).
  ENDMETHOD.

  METHOD get_name.
    ret_name = mv_name.
  ENDMETHOD.

  METHOD set_name.
    mv_name = imp_name.
  ENDMETHOD.

ENDCLASS.








