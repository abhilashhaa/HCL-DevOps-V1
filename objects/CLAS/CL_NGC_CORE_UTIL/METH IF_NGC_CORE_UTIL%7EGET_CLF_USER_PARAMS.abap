METHOD if_ngc_core_util~get_clf_user_params.

  CALL FUNCTION 'CLPR_GET_USER_DATA'
    IMPORTING
      e_clprof = es_clf_user_params
*     E_DEFAULT       =
    .

ENDMETHOD.