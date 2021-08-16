  METHOD serialize_tpool.

    DATA: lt_tpool      TYPE textpool_table,
          lv_langu      TYPE langu,
          lt_i18n_tpool TYPE zif_abapgit_lang_definitions=>tt_i18n_tpool,
          ls_i18n_tpool TYPE zif_abapgit_lang_definitions=>ty_i18n_tpool.

    lt_tpool = mi_object_oriented_object_fct->read_text_pool(
      iv_class_name = iv_clsname
      iv_language   = mv_language ).
    ii_xml->add( iv_name = 'TPOOL'
                 ig_data = add_tpool( lt_tpool ) ).

    IF ii_xml->i18n_params( )-serialize_master_lang_only IS NOT INITIAL.
      RETURN.
    ENDIF.

    LOOP AT it_langu_additional INTO lv_langu.
      CLEAR: ls_i18n_tpool.

      lt_tpool = mi_object_oriented_object_fct->read_text_pool(
            iv_class_name = iv_clsname
            iv_language   = lv_langu ).

      ls_i18n_tpool-language = lv_langu.
      ls_i18n_tpool-textpool = add_tpool( lt_tpool ).
      INSERT ls_i18n_tpool INTO TABLE lt_i18n_tpool.

    ENDLOOP.

    IF lines( lt_i18n_tpool ) > 0.
      ii_xml->add( iv_name = 'I18N_TPOOL'
                   ig_data = lt_i18n_tpool ).
    ENDIF.

  ENDMETHOD.