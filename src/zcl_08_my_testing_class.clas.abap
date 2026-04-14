CLASS zcl_08_my_testing_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_my_testing_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    data calc_lc_method type ref TO lcl_my_methods.
    create object calc_lc_method.

    calc_lc_method->lc_method(
        exporting
            lv_demo1 = 20
            lv_demo2 = 25
        RECEIVING
            rv_demo = data(my_result) ).
    out->write( my_result ).

  ENDMETHOD.
ENDCLASS.
