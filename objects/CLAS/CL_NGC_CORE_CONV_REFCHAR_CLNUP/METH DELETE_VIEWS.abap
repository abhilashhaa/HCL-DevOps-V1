  METHOD delete_views.

    TRY.
        mo_conv_util->delete_view( gv_refchars_name ).

      CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
        IF iv_log_error = abap_true.
          mo_conv_logger->log_error( lx_root ).
        ENDIF.
    ENDTRY.

    TRY.
        mo_conv_util->delete_view( gv_nodes_name ).

      CATCH cx_root INTO lx_root ##CATCH_ALL.
        IF iv_log_error = abap_true.
          mo_conv_logger->log_error( lx_root ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.