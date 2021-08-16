  METHOD get_master_lang.

    SELECT SINGLE langu FROM dokil INTO rv_language
      WHERE id = c_id
      AND object = mv_doc_object
      AND masterlang = abap_true.

    IF sy-subrc <> 0.
      rv_language = mv_language.
    ENDIF.

  ENDMETHOD.