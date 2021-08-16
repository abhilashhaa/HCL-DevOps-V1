  METHOD zif_abapgit_object~serialize.

    DATA: lt_form_data              TYPE tyt_form_data.
    DATA: ls_form_data              TYPE tys_form_data.
    DATA: lt_text_header            TYPE tyt_text_header.
    DATA: lt_lines                  TYPE tyt_lines.
    DATA: lv_form_found             TYPE abap_bool.
    FIELD-SYMBOLS: <ls_text_header> LIKE LINE OF lt_text_header.

    lt_text_header = find_form( ms_item-obj_name ).

    LOOP AT lt_text_header ASSIGNING <ls_text_header>.
      CLEAR lt_lines.
      CLEAR ls_form_data.

      _read_form( EXPORTING is_text_header = <ls_text_header>
                  IMPORTING ev_form_found = lv_form_found
                            es_form_data  = ls_form_data
                            et_lines      = lt_lines ).

      IF lv_form_found = abap_true.

        _clear_changed_fields( CHANGING cs_form_data = ls_form_data ).

        compress_lines( is_form_data = ls_form_data
                        it_lines     = lt_lines ).

        INSERT ls_form_data INTO TABLE lt_form_data.

      ENDIF.

    ENDLOOP.

    IF lt_form_data IS NOT INITIAL.

      io_xml->add( iv_name = c_objectname_form
                   ig_data = lt_form_data ).

    ENDIF.

  ENDMETHOD.