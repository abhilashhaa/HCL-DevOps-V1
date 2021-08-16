  METHOD get.

    FIELD-SYMBOLS <ls_entry> LIKE LINE OF mt_entries.
    READ TABLE mt_entries ASSIGNING <ls_entry> WITH KEY k = iv_key.
    IF sy-subrc IS INITIAL.
      rv_val = <ls_entry>-v.
    ENDIF.

  ENDMETHOD.