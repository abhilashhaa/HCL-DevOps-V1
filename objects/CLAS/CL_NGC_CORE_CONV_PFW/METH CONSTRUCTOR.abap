  METHOD constructor.

    DATA(lo_msg) = NEW cl_shdb_pfw_logging( cl_upgba_logger=>log ).

    mo_pfw = cl_shdb_pfw_factory=>register(
      iv_appl_name = iv_application_name
      ir_logwriter = lo_msg
    ).

  ENDMETHOD.