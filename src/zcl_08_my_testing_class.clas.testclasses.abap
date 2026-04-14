CLASS ltcl_zcl_my_testing_class DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS lc_method FOR TESTING.
ENDCLASS.


CLASS ltcl_zcl_my_testing_class IMPLEMENTATION.

  METHOD lc_method.
    DATA calc_lc_method TYPE REF TO lcl_my_methods.
    CREATE OBJECT calc_lc_method.

    DATA(calc_result) =  calc_lc_method->lc_method(
            lv_demo1 = 20
            lv_demo2 = 26 ).

    cl_abap_unit_assert=>assert_equals(
            EXPORTING
            act = calc_result
            exp = 45
            msg = 'something is wrong' ).

  ENDMETHOD.

ENDCLASS.
