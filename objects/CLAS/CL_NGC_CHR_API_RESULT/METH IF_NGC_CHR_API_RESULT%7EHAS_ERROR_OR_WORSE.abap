METHOD if_ngc_chr_api_result~has_error_or_worse.

  CLEAR: rv_has_error_or_worse.

  LOOP AT mt_message TRANSPORTING NO FIELDS WHERE msgty CA if_ngc_c=>gc_msg_severity_category-error_or_worse.
    rv_has_error_or_worse = abap_true.
    RETURN.
  ENDLOOP.

ENDMETHOD.