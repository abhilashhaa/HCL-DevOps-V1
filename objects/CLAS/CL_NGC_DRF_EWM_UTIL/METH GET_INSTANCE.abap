  METHOD GET_INSTANCE.

    IF go_instance IS NOT BOUND.
      go_instance = NEW cl_ngc_drf_ewm_util( iv_replication_mode ).
    ENDIF.

    ro_drf_ewm_clf_cls_chr_util = go_instance.

  ENDMETHOD.