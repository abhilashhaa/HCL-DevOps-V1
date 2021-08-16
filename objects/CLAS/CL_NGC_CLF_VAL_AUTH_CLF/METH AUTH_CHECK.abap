METHOD auth_check.

* Auth. Object.: C_KLAH_BKL.
* For create and update the activity 01 is used, for deletion, activity 02. This is because
* it is implemented the same way in the transactions.
* This implementation is based on include LCLFMF3H form authority_check_classify.

  DATA:
    lv_classclassfctnauthgrp      TYPE bgrkl,
    lv_auth_classclassfctnauthgrp TYPE boole_d,
    lv_activity                   TYPE activ_auth.

  CLEAR: rv_has_auth.

  lv_classclassfctnauthgrp = iv_classclassfctnauthgrp.

  " here we handle updated as '01' also, because in case of the transaction, changing
  " an already assigned class is also called as a create.
  lv_activity = COND #( WHEN iv_object_state = if_ngc_c=>gc_object_state-created
                          OR iv_object_state = if_ngc_c=>gc_object_state-updated THEN '01'
                        WHEN iv_object_state = if_ngc_c=>gc_object_state-deleted THEN '02' ).

  " this is needed because in the transaction the auth. group of the class is only
  " retrieved if the activity is not '01' (include LCLFMF3H line 40)
  IF iv_object_state = if_ngc_c=>gc_object_state-created OR
     iv_object_state = if_ngc_c=>gc_object_state-updated.
    CLEAR: lv_classclassfctnauthgrp.
  ENDIF.

  TEST-SEAM auth_check.

    IF iv_classclassfctnauthgrp IS NOT INITIAL.
      AUTHORITY-CHECK OBJECT 'C_KLAH_BKL'
            ID 'BGRKL' FIELD  iv_classclassfctnauthgrp
            ID 'ACTVT' FIELD  lv_activity.
      lv_auth_classclassfctnauthgrp = boolc( sy-subrc = 0 ).
    ELSE.
      lv_auth_classclassfctnauthgrp = abap_true.
    ENDIF.

    " dummy is always needed in case of create/update; in case of delete only if auth. group is empty
    sy-subrc = 0.
    IF iv_object_state = if_ngc_c=>gc_object_state-created OR
       iv_object_state = if_ngc_c=>gc_object_state-updated OR
       ( iv_object_state = if_ngc_c=>gc_object_state-deleted AND iv_classclassfctnauthgrp IS INITIAL ).
      AUTHORITY-CHECK OBJECT 'C_KLAH_BKL'
            ID 'BGRKL' DUMMY
            ID 'ACTVT' FIELD  lv_activity.
    ENDIF.

    rv_has_auth = boolc( sy-subrc = 0 AND lv_auth_classclassfctnauthgrp = abap_true ).

  END-TEST-SEAM.

ENDMETHOD.