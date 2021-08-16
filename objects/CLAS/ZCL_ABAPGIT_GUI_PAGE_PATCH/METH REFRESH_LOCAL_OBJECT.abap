  METHOD refresh_local_object.

    DATA:
      lv_regex    TYPE string,
      lv_obj_type TYPE tadir-object,
      lv_obj_name TYPE tadir-obj_name.

    lv_regex = c_actions-refresh_local_object && `_(\w{4})_(.*)`.

    FIND FIRST OCCURRENCE OF REGEX lv_regex
      IN iv_action
      SUBMATCHES lv_obj_type lv_obj_name.

    IF sy-subrc = 0.
      mo_repo->refresh_local_object(
          iv_obj_type = lv_obj_type
          iv_obj_name = lv_obj_name ).
    ELSE.
      zcx_abapgit_exception=>raise( |Invalid refresh action { iv_action }| ).
    ENDIF.

  ENDMETHOD.