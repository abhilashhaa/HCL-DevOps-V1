  METHOD zif_abapgit_object~exists.

    CALL METHOD ('CL_OA2P_OBJECT_PERSIST')=>('CHECK_EXISTS_ON_DB')
      EXPORTING
        i_profile = mv_profile
      RECEIVING
        r_exists  = rv_bool.

  ENDMETHOD.