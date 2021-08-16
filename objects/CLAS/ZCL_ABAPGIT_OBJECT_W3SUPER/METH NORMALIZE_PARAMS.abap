  METHOD normalize_params.

    FIELD-SYMBOLS <ls_param> LIKE LINE OF ct_params.

    " Ensure filesize param exists
    READ TABLE ct_params ASSIGNING <ls_param> WITH KEY name = c_param_names-filesize.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO ct_params ASSIGNING <ls_param>.
      <ls_param>-name  = c_param_names-filesize.
    ENDIF.

    LOOP AT ct_params ASSIGNING <ls_param>.
      <ls_param>-relid = ms_key-relid. " Ensure param key = object key
      <ls_param>-objid = ms_key-objid.
      IF <ls_param>-name = c_param_names-filesize. " Patch filesize = real file size
        <ls_param>-value = iv_size.
        CONDENSE <ls_param>-value.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.