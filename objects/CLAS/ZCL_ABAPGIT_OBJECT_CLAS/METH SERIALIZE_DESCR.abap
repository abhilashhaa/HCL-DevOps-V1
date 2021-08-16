  METHOD serialize_descr.

    DATA: lt_descriptions TYPE zif_abapgit_definitions=>ty_seocompotx_tt,
          lv_language     TYPE spras.

    IF ii_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      lv_language = mv_language.
    ENDIF.

    lt_descriptions = mi_object_oriented_object_fct->read_descriptions(
      iv_obejct_name = iv_clsname
      iv_language = lv_language ).

    IF lines( lt_descriptions ) = 0.
      RETURN.
    ENDIF.

    ii_xml->add( iv_name = 'DESCRIPTIONS'
                 ig_data = lt_descriptions ).

  ENDMETHOD.