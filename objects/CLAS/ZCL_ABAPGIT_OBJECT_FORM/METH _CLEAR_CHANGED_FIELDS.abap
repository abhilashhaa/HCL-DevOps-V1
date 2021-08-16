  METHOD _clear_changed_fields.

    CLEAR: cs_form_data-form_header-tdfuser,
           cs_form_data-form_header-tdfdate,
           cs_form_data-form_header-tdftime,
           cs_form_data-form_header-tdfreles,
           cs_form_data-form_header-tdluser,
           cs_form_data-form_header-tdldate,
           cs_form_data-form_header-tdltime,
           cs_form_data-form_header-tdlreles.
    CLEAR: cs_form_data-text_header-tdfuser,
           cs_form_data-text_header-tdfdate,
           cs_form_data-text_header-tdftime,
           cs_form_data-text_header-tdfreles,
           cs_form_data-text_header-tdluser,
           cs_form_data-text_header-tdldate,
           cs_form_data-text_header-tdltime,
           cs_form_data-text_header-tdlreles.

  ENDMETHOD.