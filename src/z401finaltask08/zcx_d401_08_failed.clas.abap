"! <p class="short_text synchronised">Custom exception for final task 08</p>
"! This exception is raised when at least one truck has a cargo capacity
"! below the required minimum of 2 tons.
"! The exception text is based on a T100 message.
CLASS zcx_d401_08_failed DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_t100_message.                 "Interface for T100-based exception texts

    "T100 message key for the case "truck below minimum capacity"
    CONSTANTS:
      BEGIN OF truck_too_small,
        msgid TYPE symsgid VALUE 'ZD401_08_MSG',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MAKE',
        attr2 TYPE scx_attrname VALUE 'MODEL',
        attr3 TYPE scx_attrname VALUE 'CARGO_TEXT',
        attr4 TYPE scx_attrname VALUE '',
      END OF truck_too_small.

    DATA make       TYPE string READ-ONLY.        "Truck 'make' used for placeholder &1
    DATA model      TYPE string READ-ONLY.        "Truck 'model' used for placeholder &2
    DATA cargo_text TYPE string READ-ONLY.        "Cargo value used for placeholder &3

    "! <p class="shorttext synchronized">Constructor for T100-based exception</p>
    "! @parameter textid     | T100 message key
    "! @parameter previous   | Previous exception in exception chain
    "! @parameter make       | Truck make for message placeholder &1
    "! @parameter model      | Truck model for message placeholder &2
    "! @parameter cargo_text | Cargo value for message placeholder &3
    METHODS constructor
      IMPORTING
        textid     LIKE if_t100_message=>t100key OPTIONAL
        previous   LIKE previous OPTIONAL
        make       TYPE string OPTIONAL
        model      TYPE string OPTIONAL
        cargo_text TYPE string OPTIONAL.
ENDCLASS.



CLASS zcx_d401_08_failed IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(                                  " Call the parent exception constructor
      previous = previous
    ).
    " Store values used by the T100 place holders
    me->make       = make.
    me->model      = model.
    me->cargo_text = cargo_text.

    " If no specific textid is provided, use the default message constant
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = truck_too_small.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
