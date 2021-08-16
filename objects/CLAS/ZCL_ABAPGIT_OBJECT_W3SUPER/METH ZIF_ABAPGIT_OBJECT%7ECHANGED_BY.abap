  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE chname INTO rv_user
      FROM wwwdata
      WHERE relid = ms_key-relid
      AND objid = ms_key-objid
      AND srtf2 = 0.

    IF sy-subrc IS NOT INITIAL OR rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.