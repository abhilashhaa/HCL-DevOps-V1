  METHOD get_instance.

    IF iv_user = sy-uname ##USER_OK.
      IF gi_current_user IS NOT BOUND.
        CREATE OBJECT gi_current_user TYPE zcl_abapgit_persistence_user.
      ENDIF.
      ri_user = gi_current_user.
    ELSE.
      CREATE OBJECT ri_user TYPE zcl_abapgit_persistence_user
        EXPORTING
          iv_user = iv_user.
    ENDIF.

  ENDMETHOD.