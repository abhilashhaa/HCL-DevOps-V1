  METHOD zif_abapgit_object~exists.

    SELECT SINGLE objid INTO ms_key-objid
      FROM wwwdata
      WHERE relid = ms_key-relid
      AND objid = ms_key-objid
      AND srtf2 = 0.

    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    rv_bool = abap_true.

  ENDMETHOD.