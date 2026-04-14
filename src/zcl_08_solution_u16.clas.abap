CLASS zcl_08_solution_u16 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_08_SOLUTION_U16 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.    "creating a constant with name c_carrier_id

    TRY.
        DATA(carrier) = NEW lcl_carrier(  i_carrier_id = c_carrier_id ). "Creating a new object instance of the class 'lcl_carrier' & calling its 'Constructor'
                                                                         " and assigning the value 'LH' from c_carrier_id to i_carrier_id of class lcl_carrier
        "Ex. 6: cheking the get.output() method types...
        out->write(  name = `Carrier Overview`
                     data = carrier->get_output(  ) ).   "calls the method 'get_output' on the new object 'carrier' from local class lcl_carrier

      CATCH cx_abap_invalid_value.
        out->write( | Carrier { c_carrier_id } does not exist | ).
    ENDTRY.

    IF carrier IS BOUND.    "check if the 'carrier' points to an object i.e. the reference in not Initial/Null

      out->write(  `--------------------------------------------------` ).

* Find a passenger flight from Frankfurt to New York
* starting as soon as possible after tomorrow
* with at least 5 free seats

      DATA(today) = cl_abap_context_info=>get_system_date(  ). "this get the system date and stores in today

      carrier->find_passenger_flight(       "calling the 'find_passenger_flight' method on the object instance 'carrier' from local class lcl_carrier
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_seats           = 5
         IMPORTING
           e_flight =     DATA(pass_flight)
           e_days_later = DATA(days_later)
                         ).

      IF pass_flight IS BOUND.  "checks if 'pass_flight' exist
        out->write( name = |Found a suitable passenger flight in { days_later } days:|
                    data = pass_flight->get_description( ) ).
      ELSE.
        out->write( data = `No Passenger Flight found` ).
      ENDIF.

      out->write(  `--------------------------------------------------` ).

** Find a cargo flight from Frankfurt to New York
** starting as soon as possible but earliest in 7 days
** with at least 1200 KG free capacity
*
      carrier->find_cargo_flight(   "still, use the object 'carrier' we created to search  on the methos 'find_cargo_flight'
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_cargo           = 1200
         IMPORTING
           e_flight =     DATA(cargo_flight)
           e_days_later = DATA(days_later2)
                         ).

      IF cargo_flight IS BOUND.
        out->write( name = |Found a suitable cargo flight in { days_later2 } days:|
                    data = cargo_flight->get_description( ) ). " start of tracing 3. output using 'get_description'
      ELSE.
        out->write( data = `No cargo flight found` ).
      ENDIF.



    ENDIF.

  ENDMETHOD.
ENDCLASS.
