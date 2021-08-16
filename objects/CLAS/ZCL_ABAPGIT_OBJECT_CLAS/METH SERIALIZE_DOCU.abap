  METHOD serialize_docu.

    DATA: lt_lines      TYPE tlinetab,
          lv_langu      TYPE langu,
          lt_i18n_lines TYPE zif_abapgit_lang_definitions=>tt_i18n_lines,
          ls_i18n_lines TYPE zif_abapgit_lang_definitions=>ty_i18n_lines.

    lt_lines = mi_object_oriented_object_fct->read_documentation(
      iv_class_name = iv_clsname
      iv_language   = mv_language ).
    IF lines( lt_lines ) > 0.
      ii_xml->add( iv_name = 'LINES'
                   ig_data = lt_lines ).
    ENDIF.

    IF ii_xml->i18n_params( )-serialize_master_lang_only IS NOT INITIAL.
      RETURN.
    ENDIF.

    LOOP AT it_langu_additional INTO lv_langu.
      CLEAR: ls_i18n_lines.

      lt_lines = mi_object_oriented_object_fct->read_documentation(
        iv_class_name = iv_clsname
        iv_language   = lv_langu ).

      ls_i18n_lines-language = lv_langu.
      ls_i18n_lines-lines    = lt_lines.
      INSERT ls_i18n_lines INTO TABLE lt_i18n_lines.

    ENDLOOP.

    IF lines( lt_i18n_lines ) > 0.
      ii_xml->add( iv_name = 'I18N_LINES'
                   ig_data = lt_i18n_lines ).
    ENDIF.

  ENDMETHOD.