  METHOD zif_abapgit_object~delete.

    DATA: lv_id     TYPE dokhl-id,
          lv_object TYPE dokhl-object.


    lv_id = ms_item-obj_name(2).
    lv_object = ms_item-obj_name+2.

    CALL FUNCTION 'DOCU_DEL'
      EXPORTING
        id       = lv_id
        langu    = mv_language
        object   = lv_object
        typ      = c_typ
      EXCEPTIONS
        ret_code = 1
        OTHERS   = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from DOCU_DEL' ).
    ENDIF.

  ENDMETHOD.