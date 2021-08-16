  METHOD add_to_return.

    FIELD-SYMBOLS: <ls_file>   LIKE LINE OF is_fils_item-files,
                   <ls_return> LIKE LINE OF mt_files.


    LOOP AT is_fils_item-files ASSIGNING <ls_file>.
      APPEND INITIAL LINE TO mt_files ASSIGNING <ls_return>.
      <ls_return>-file = <ls_file>.
      <ls_return>-file-path = iv_path.
      <ls_return>-item = is_fils_item-item.
    ENDLOOP.

  ENDMETHOD.