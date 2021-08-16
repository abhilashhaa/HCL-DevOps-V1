  METHOD _read_form.

    CLEAR es_form_data.

    CALL FUNCTION 'READ_FORM'
      EXPORTING
        form         = is_text_header-tdform
        language     = is_text_header-tdspras
        status       = ' '
      IMPORTING
        form_header  = es_form_data-form_header
        found        = ev_form_found
        header       = es_form_data-text_header
        olanguage    = es_form_data-orig_language
      TABLES
        form_lines   = et_lines
        pages        = es_form_data-pages
        page_windows = es_form_data-page_windows
        paragraphs   = es_form_data-paragraphs
        strings      = es_form_data-strings
        tabs         = es_form_data-tabs
        windows      = es_form_data-windows.

    _sort_tdlines_by_windows( CHANGING ct_form_windows  = es_form_data-windows
                                       ct_lines         = et_lines ).

    es_form_data-form_header-tdversion = '00001'.
    es_form_data-text_header-tdversion = '00001'.

  ENDMETHOD.