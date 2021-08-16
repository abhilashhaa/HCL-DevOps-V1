  METHOD authenticate.
    RAISE EXCEPTION TYPE zcx_abapgit_2fa_auth_failed. " Needs to be overwritten in subclasses
  ENDMETHOD.