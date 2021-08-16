  METHOD delete_access_tokens.
    RAISE EXCEPTION TYPE zcx_abapgit_2fa_del_failed. " Needs to be overwritten in subclasses
  ENDMETHOD.