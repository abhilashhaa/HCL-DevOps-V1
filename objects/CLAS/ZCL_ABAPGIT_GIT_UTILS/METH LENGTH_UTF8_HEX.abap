  METHOD length_utf8_hex.

    DATA: lv_xstring TYPE xstring,
          lv_string  TYPE string,
          lv_char4   TYPE c LENGTH 4,
          lv_x       TYPE x LENGTH 2,
          lo_obj     TYPE REF TO cl_abap_conv_in_ce,
          lv_len     TYPE i.

* hmm, can this be done easier?

    lv_xstring = iv_data(4).

    lo_obj = cl_abap_conv_in_ce=>create(
        input    = lv_xstring
        encoding = 'UTF-8' ).
    lv_len = xstrlen( lv_xstring ).

    TRY.
        lo_obj->read( EXPORTING n    = lv_len
                      IMPORTING data = lv_string ).
      CATCH cx_sy_conversion_codepage.
        zcx_abapgit_exception=>raise( 'error converting to hex, LENGTH_UTF8_HEX' ).
    ENDTRY.

    lv_char4 = lv_string.
    TRANSLATE lv_char4 TO UPPER CASE.
    lv_x = lv_char4.
    rv_len = lv_x.

  ENDMETHOD.