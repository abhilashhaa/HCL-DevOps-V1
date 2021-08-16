  METHOD zif_abapgit_longtexts~serialize.

    DATA lt_longtexts TYPE tty_longtexts.
    DATA lt_dokil LIKE it_dokil.
    DATA lv_master_lang_only TYPE abap_bool.

    lt_dokil = it_dokil.
    lv_master_lang_only = ii_xml->i18n_params( )-serialize_master_lang_only.
    IF lv_master_lang_only = abap_true.
      DELETE lt_dokil WHERE masterlang <> abap_true.
    ENDIF.

    lt_longtexts = read( iv_object_name = iv_object_name
                         iv_longtext_id = iv_longtext_id
                         it_dokil       = lt_dokil
                         iv_master_lang_only = lv_master_lang_only ).

    ii_xml->add( iv_name = iv_longtext_name
                 ig_data = lt_longtexts ).

  ENDMETHOD.