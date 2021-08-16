  METHOD find_param.

    FIELD-SYMBOLS <ls_param> LIKE LINE OF it_params.


    READ TABLE it_params ASSIGNING <ls_param> WITH KEY name = iv_name.
    IF sy-subrc > 0.
      zcx_abapgit_exception=>raise( |W3xx: Cannot find { iv_name } for { ms_key-objid }| ).
    ENDIF.

    rv_value = <ls_param>-value.

  ENDMETHOD.