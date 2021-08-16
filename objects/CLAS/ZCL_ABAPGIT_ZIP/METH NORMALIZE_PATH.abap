  METHOD normalize_path.
* removes first folder from path if needed

    DATA: lt_split  TYPE TABLE OF string,
          lv_needed TYPE abap_bool,
          lv_length TYPE i,
          lv_split  LIKE LINE OF lt_split.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF ct_files.


    READ TABLE ct_files INDEX 1 ASSIGNING <ls_file>.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    SPLIT <ls_file>-path AT '/' INTO TABLE lt_split.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    READ TABLE lt_split INDEX 2 INTO lv_split.
    IF sy-subrc <> 0 OR strlen( lv_split ) = 0.
      RETURN.
    ENDIF.

    CONCATENATE '/' lv_split '/*' INTO lv_split.

    lv_needed = abap_true.
    LOOP AT ct_files ASSIGNING <ls_file>.
      IF NOT <ls_file>-path CP lv_split.
        lv_needed = abap_false.
        EXIT. " current loop
      ENDIF.
    ENDLOOP.

    IF lv_needed = abap_true.
      lv_length = strlen( lv_split ) - 2.
      LOOP AT ct_files ASSIGNING <ls_file>.
        <ls_file>-path = <ls_file>-path+lv_length.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.