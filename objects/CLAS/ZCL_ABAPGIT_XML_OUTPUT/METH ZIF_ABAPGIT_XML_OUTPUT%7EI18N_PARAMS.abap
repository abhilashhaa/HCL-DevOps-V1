  METHOD zif_abapgit_xml_output~i18n_params.

    IF iv_serialize_master_lang_only IS SUPPLIED.
      ms_i18n_params-serialize_master_lang_only = iv_serialize_master_lang_only.
    ENDIF.

    rs_params = ms_i18n_params.

  ENDMETHOD.