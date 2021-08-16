  METHOD zif_abapgit_object~changed_by.

    rv_user = mi_longtexts->changed_by(
                  iv_object_name = ms_item-obj_name
                  iv_longtext_id = c_id ).

    IF rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.