CLASS lcl_my_methods DEFINITION CREATE public.

  PUBLIC SECTION.

    METHODS lc_method IMPORTING lv_demo1       TYPE i
                                lv_demo2       TYPE i
                      RETURNING VALUE(rv_demo) TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_my_methods IMPLEMENTATION.

  METHOD lc_method.
    rv_demo = lv_demo1 + lv_demo2.
  ENDMETHOD.

ENDCLASS.
