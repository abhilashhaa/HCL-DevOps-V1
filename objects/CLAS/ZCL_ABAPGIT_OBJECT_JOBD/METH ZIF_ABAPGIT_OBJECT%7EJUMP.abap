  METHOD zif_abapgit_object~jump.

    DATA: lv_obj_name TYPE e071-obj_name.


    lv_obj_name = ms_item-obj_name.

    CALL FUNCTION 'TR_OBJECT_JUMP_TO_TOOL'
      EXPORTING
        iv_pgmid          = 'R3TR'
        iv_object         = ms_item-obj_type
        iv_obj_name       = lv_obj_name
        iv_action         = 'SHOW'
      EXCEPTIONS
        jump_not_possible = 1
        OTHERS            = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from TR_OBJECT_JUMP_TO_TOOL, JOBD| ).
    ENDIF.

  ENDMETHOD.