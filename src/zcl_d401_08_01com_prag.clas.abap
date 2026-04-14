CLASS zcl_d401_08_01com_prag DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d401_08_01com_prag IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT FROM /dmo/connection FIELDS * into table @data(lt_result).  "#EC CI_NOWHERE
    out->write(  EXPORTING data = lt_result name = 'Connections' ) ##NO_TEXT.

    SELECT FROM /dmo/connection FIELDS * into table @lt_result.
    out->write(  EXPORTING data = lt_result name = 'Connections' ).
  ENDMETHOD.
ENDCLASS.
