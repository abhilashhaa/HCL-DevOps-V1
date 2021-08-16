  METHOD zif_abapgit_object~changed_by.
    SELECT SINGLE changed_by FROM cls_type_group INTO rv_user
      WHERE name = ms_item-obj_name
      AND activation_state = cl_pak_wb_domains=>co_activation_state-active.

    IF rv_user IS INITIAL.
      SELECT SINGLE created_by FROM cls_type_group INTO rv_user
        WHERE name = ms_item-obj_name
        AND activation_state = cl_pak_wb_domains=>co_activation_state-active.
    ENDIF.

    IF rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.
  ENDMETHOD.