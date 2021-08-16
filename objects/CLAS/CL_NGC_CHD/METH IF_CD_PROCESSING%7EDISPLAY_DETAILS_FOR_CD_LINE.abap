  METHOD if_cd_processing~display_details_for_cd_line.

    SELECT SINGLE *
      FROM inob
      WHERE cuobj EQ @is_change_document_line-tabkey(18)
      INTO @DATA(ls_inob).

    CALL FUNCTION 'CLLA_CHANGE_DOC_CLASSIFICATION'
      EXPORTING
        object       = ls_inob-objek
        classtype    = ls_inob-klart
        object_type  = ls_inob-obtab
      EXCEPTIONS
        no_data      = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.