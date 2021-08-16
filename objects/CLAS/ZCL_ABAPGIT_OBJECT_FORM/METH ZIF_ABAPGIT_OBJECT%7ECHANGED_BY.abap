  METHOD zif_abapgit_object~changed_by.

    DATA: ls_last_changed TYPE tys_form_header.

    ls_last_changed = get_last_changes( ms_item-obj_name ).

    IF ls_last_changed-tdluser IS NOT INITIAL.
      rv_user = ls_last_changed-tdluser.
    ELSE.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.