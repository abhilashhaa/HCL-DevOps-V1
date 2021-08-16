  METHOD deserialize_texts.

    DATA: lt_tpool_i18n TYPE tt_tpool_i18n,
          lt_tpool      TYPE textpool_table.

    FIELD-SYMBOLS <ls_tpool> LIKE LINE OF lt_tpool_i18n.


    ii_xml->read( EXPORTING iv_name = 'I18N_TPOOL'
                  CHANGING  cg_data = lt_tpool_i18n ).

    LOOP AT lt_tpool_i18n ASSIGNING <ls_tpool>.
      lt_tpool = read_tpool( <ls_tpool>-textpool ).
      deserialize_textpool( iv_program  = ms_item-obj_name
                            iv_language = <ls_tpool>-language
                            it_tpool    = lt_tpool ).
    ENDLOOP.

  ENDMETHOD.