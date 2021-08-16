  METHOD serialize_texts.

    DATA lt_tpool_i18n TYPE TABLE OF tstct.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      RETURN.
    ENDIF.

    " Skip master language - it was already serialized
    " Don't serialize t-code itself
    SELECT sprsl ttext
      INTO CORRESPONDING FIELDS OF TABLE lt_tpool_i18n
      FROM tstct
      WHERE sprsl <> mv_language
      AND   tcode = ms_item-obj_name ##TOO_MANY_ITAB_FIELDS. "#EC CI_GENBUFF

    IF lines( lt_tpool_i18n ) > 0.
      SORT lt_tpool_i18n BY sprsl ASCENDING.
      io_xml->add( iv_name = 'I18N_TPOOL'
                   ig_data = lt_tpool_i18n ).
    ENDIF.

  ENDMETHOD.