METHOD get_instance.

  IF go_instance IS INITIAL.
    go_instance = NEW cl_ngc_drf_util( iv_replication_mode ).
  ENDIF.

  ro_instance = go_instance.

ENDMETHOD.