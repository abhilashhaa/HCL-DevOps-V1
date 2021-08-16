  METHOD deserialize_tpool.

    DATA: lv_clsname    TYPE seoclsname,
          lt_tpool_ext  TYPE zif_abapgit_definitions=>ty_tpool_tt,
          lt_tpool      TYPE textpool_table,
          lt_i18n_tpool TYPE zif_abapgit_lang_definitions=>tt_i18n_tpool,
          ls_i18n_tpool TYPE zif_abapgit_lang_definitions=>ty_i18n_tpool.


    ii_xml->read( EXPORTING iv_name = 'TPOOL'
                  CHANGING cg_data = lt_tpool_ext ).
    lt_tpool = read_tpool( lt_tpool_ext ).

    IF lines( lt_tpool ) = 0.
      RETURN.
    ENDIF.

    lv_clsname = ms_item-obj_name.

    mi_object_oriented_object_fct->insert_text_pool(
      iv_class_name = lv_clsname
      it_text_pool  = lt_tpool
      iv_language   = mv_language ).

    ii_xml->read( EXPORTING iv_name = 'I18N_TPOOL'
                  CHANGING  cg_data = lt_i18n_tpool ).

    LOOP AT lt_i18n_tpool INTO ls_i18n_tpool.
      lt_tpool = read_tpool( ls_i18n_tpool-textpool ).
      mi_object_oriented_object_fct->insert_text_pool(
        iv_class_name = lv_clsname
        it_text_pool  = lt_tpool
        iv_language   = ls_i18n_tpool-language
        iv_state      = 'A' ).
    ENDLOOP.

  ENDMETHOD.