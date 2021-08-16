  METHOD clear_idoc_segement_field.

    FIELD-SYMBOLS <lg_any_field> TYPE any.

    ASSIGN COMPONENT iv_fieldname OF STRUCTURE cg_structure TO <lg_any_field>.
    IF sy-subrc = 0.
      CLEAR <lg_any_field>.
    ENDIF.

  ENDMETHOD.