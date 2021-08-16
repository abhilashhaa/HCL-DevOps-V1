  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE uname
      INTO rv_user
      FROM hrs1201
      WHERE otype = c_object_type_task AND
            objid = ms_item-obj_name.

    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.