
CLASS ltc_ngc_core_util DEFINITION DEFERRED.
CLASS cl_ngc_core_util  DEFINITION LOCAL FRIENDS ltc_ngc_core_util .

CLASS ltc_ngc_core_util DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_core_util.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_number_separator_signs FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_core_util IMPLEMENTATION.

  METHOD setup.
    mo_cut = cl_ngc_core_util=>get_instance( ).
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD get_number_separator_signs.
    mo_cut->if_ngc_core_util~get_number_separator_signs( ).

*    cl_abap_unit_assert=>assert( ).
  ENDMETHOD.

ENDCLASS.