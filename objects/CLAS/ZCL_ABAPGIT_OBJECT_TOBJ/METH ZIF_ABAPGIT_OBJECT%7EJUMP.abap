  METHOD zif_abapgit_object~jump.

    DATA: lv_object_name TYPE e071-obj_name.

    lv_object_name = ms_item-obj_name.

    CALL FUNCTION 'TR_OBJECT_JUMP_TO_TOOL'
      EXPORTING
        iv_pgmid          = 'R3TR'
        iv_object         = ms_item-obj_type
        iv_obj_name       = lv_object_name
      EXCEPTIONS
        jump_not_possible = 1
        OTHERS            = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Jump not possible. Subrc={ sy-subrc } from TR_OBJECT_JUMP_TO_TOOL| ).
    ENDIF.

  ENDMETHOD.