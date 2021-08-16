  METHOD jump_encode.

    DATA: lt_fields TYPE tihttpnvp.


    add_field( EXPORTING iv_name = 'TYPE'
                         ig_field = iv_obj_type CHANGING ct_field = lt_fields ).
    add_field( EXPORTING iv_name = 'NAME'
                         ig_field = iv_obj_name CHANGING ct_field = lt_fields ).

    rv_string = cl_http_utility=>if_http_utility~fields_to_string( lt_fields ).

  ENDMETHOD.