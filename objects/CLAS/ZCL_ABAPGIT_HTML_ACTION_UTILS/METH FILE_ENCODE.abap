  METHOD file_encode.

    DATA: lt_fields TYPE tihttpnvp.


    add_field( EXPORTING iv_name = 'KEY'
                         ig_field = iv_key CHANGING ct_field = lt_fields ).
    add_field( EXPORTING iv_name = 'PATH'
                         ig_field = ig_file CHANGING ct_field = lt_fields ).
    add_field( EXPORTING iv_name = 'FILENAME'
                         ig_field = ig_file CHANGING ct_field = lt_fields ).

    rv_string = cl_http_utility=>if_http_utility~fields_to_string( lt_fields ).

  ENDMETHOD.