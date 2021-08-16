  METHOD get_instance.

    IF gi_exit IS INITIAL.
      TRY.
          CREATE OBJECT gi_exit TYPE ('ZCL_ABAPGIT_USER_EXIT').
        CATCH cx_sy_create_object_error ##NO_HANDLER.
      ENDTRY.
    ENDIF.

    CREATE OBJECT ri_exit TYPE zcl_abapgit_exit.

  ENDMETHOD.