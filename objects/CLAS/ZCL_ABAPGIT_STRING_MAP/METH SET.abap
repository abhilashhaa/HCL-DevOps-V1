  METHOD set.

    DATA ls_entry LIKE LINE OF mt_entries.
    FIELD-SYMBOLS <ls_entry> LIKE LINE OF mt_entries.

    IF mv_read_only = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot set. This string map is immutable' ).
    ENDIF.

    READ TABLE mt_entries ASSIGNING <ls_entry> WITH KEY k = iv_key.
    IF sy-subrc IS INITIAL.
      <ls_entry>-v = iv_val.
    ELSE.
      ls_entry-k = iv_key.
      ls_entry-v = iv_val.
      INSERT ls_entry INTO TABLE mt_entries.
    ENDIF.

    ro_map = me.

  ENDMETHOD.