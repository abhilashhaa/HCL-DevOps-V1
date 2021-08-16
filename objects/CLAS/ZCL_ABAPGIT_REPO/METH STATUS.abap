  METHOD status.

    IF lines( mt_status ) = 0.
      mt_status = zcl_abapgit_file_status=>status(
        io_repo = me
        ii_log  = ii_log ).
    ENDIF.

    rt_results = mt_status.

  ENDMETHOD.