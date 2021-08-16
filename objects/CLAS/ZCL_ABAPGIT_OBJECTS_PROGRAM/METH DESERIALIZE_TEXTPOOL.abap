  METHOD deserialize_textpool.

    DATA lv_language TYPE langu.
    DATA lv_state    TYPE c.
    DATA lv_delete   TYPE abap_bool.

    IF iv_language IS INITIAL.
      lv_language = mv_language.
    ELSE.
      lv_language = iv_language.
    ENDIF.

    IF lv_language = mv_language.
      lv_state = 'I'. "Textpool in master language needs to be activated
    ELSE.
      lv_state = 'A'. "Translations are always active
    ENDIF.

    IF it_tpool IS INITIAL.
      IF iv_is_include = abap_false OR lv_state = 'A'.
        DELETE TEXTPOOL iv_program "Remove initial description from textpool if
          LANGUAGE lv_language     "original program does not have a textpool
          STATE lv_state.

        lv_delete = abap_true.
      ELSE.
        INSERT TEXTPOOL iv_program "In case of includes: Deletion of textpool in
          FROM it_tpool            "master language cannot be activated because
          LANGUAGE lv_language     "this woul activate the deletion of the textpool
          STATE lv_state.          "of the mail program -> insert empty textpool
      ENDIF.
    ELSE.
      IF lines( it_tpool ) = 1 AND lv_language = mv_language.
        READ TABLE it_tpool WITH KEY id = 'R' TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          RETURN. "No action because description in master language is already there
        ENDIF.
      ENDIF.

      INSERT TEXTPOOL iv_program
        FROM it_tpool
        LANGUAGE lv_language
        STATE lv_state.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from INSERT TEXTPOOL' ).
      ENDIF.
    ENDIF.

    IF lv_state = 'I'. "Textpool in master language needs to be activated
      zcl_abapgit_objects_activation=>add(
        iv_type   = 'REPT'
        iv_name   = iv_program
        iv_delete = lv_delete ).
    ENDIF.
  ENDMETHOD.