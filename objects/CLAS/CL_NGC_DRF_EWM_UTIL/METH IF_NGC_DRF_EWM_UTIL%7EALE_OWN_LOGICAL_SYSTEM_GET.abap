METHOD if_ngc_drf_ewm_util~ale_own_logical_system_get.
  CALL FUNCTION 'OWN_LOGICAL_SYSTEM_GET'
    IMPORTING
      own_logical_system             = ev_own_logical_system
    EXCEPTIONS
      own_logical_system_not_defined = 1
      OTHERS                         = 2.
  ev_subrc = sy-subrc.
ENDMETHOD.