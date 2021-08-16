  METHOD deserialize_texts.

    DATA lt_tpool_i18n TYPE TABLE OF tstct.

    FIELD-SYMBOLS <ls_tpool> LIKE LINE OF lt_tpool_i18n.


    " Read XML-files data
    io_xml->read( EXPORTING iv_name = 'I18N_TPOOL'
                  CHANGING  cg_data = lt_tpool_i18n ).

    " Force t-code name (security reasons)
    LOOP AT lt_tpool_i18n ASSIGNING <ls_tpool>.
      <ls_tpool>-tcode = ms_item-obj_name.
    ENDLOOP.

    IF lines( lt_tpool_i18n ) > 0.
      MODIFY tstct FROM TABLE lt_tpool_i18n.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Update of t-code translations failed' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.