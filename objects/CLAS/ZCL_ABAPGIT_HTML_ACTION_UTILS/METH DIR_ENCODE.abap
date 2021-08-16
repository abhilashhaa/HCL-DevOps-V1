  METHOD dir_encode.

    DATA: lt_fields TYPE tihttpnvp.
    add_field( EXPORTING iv_name = 'PATH'
                         ig_field = iv_path CHANGING ct_field = lt_fields ).
    rv_string = cl_http_utility=>if_http_utility~fields_to_string( lt_fields ).

  ENDMETHOD.