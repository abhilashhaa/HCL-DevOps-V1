  METHOD get_name.
    rv_name = super->get_name( ).
    IF rv_name IS INITIAL.
      rv_name = zcl_abapgit_url=>name( ms_data-url ).
      rv_name = cl_http_utility=>if_http_utility~unescape_url( rv_name ).
    ENDIF.
  ENDMETHOD.