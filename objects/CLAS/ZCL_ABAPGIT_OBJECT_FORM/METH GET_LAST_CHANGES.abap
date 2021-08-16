  METHOD get_last_changes.

    DATA: lv_form_name         TYPE thead-tdform.

    CLEAR rs_last_changed.

    lv_form_name = iv_form_name.

    CALL FUNCTION 'READ_FORM'
      EXPORTING
        form             = lv_form_name
        read_only_header = abap_true
      IMPORTING
        form_header      = rs_last_changed.

  ENDMETHOD.