METHOD if_ngc_drf_ewm_util~rfc_trfc_set_qin_properties.
  CALL FUNCTION 'TRFC_SET_QIN_PROPERTIES'
    EXPORTING
      qout_name          = iv_qout_name
      qin_name           = iv_qin_name
      qin_count          = iv_qin_count
      call_event         = iv_call_event
      no_execute         = iv_no_execute
    EXCEPTIONS
      invalid_queue_name = 1
      OTHERS             = 2.
  ev_subrc = sy-subrc.
ENDMETHOD.