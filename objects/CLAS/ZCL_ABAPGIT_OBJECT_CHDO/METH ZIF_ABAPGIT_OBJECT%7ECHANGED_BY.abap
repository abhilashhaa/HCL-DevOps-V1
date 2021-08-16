  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE updname INTO rv_user
      FROM tcdrp
      WHERE object = mv_object.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.