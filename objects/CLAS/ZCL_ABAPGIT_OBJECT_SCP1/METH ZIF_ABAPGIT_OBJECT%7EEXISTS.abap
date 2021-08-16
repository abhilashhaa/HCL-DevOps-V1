  METHOD zif_abapgit_object~exists.

    DATA: lv_rc     TYPE sy-subrc,
          lv_profid TYPE scprattr-id.


    lv_profid = ms_item-obj_name.

    CALL FUNCTION 'SCPR_BCSET_EXISTS'
      EXPORTING
        profid = lv_profid
      IMPORTING
        rc     = lv_rc.
    rv_bool = boolc( lv_rc = 0 ).

  ENDMETHOD.