  METHOD constructor.

    mv_appl_name            = iv_appl_name.
    mv_language             = iv_language.
    mv_lock                 = iv_lock.
    mv_testmode             = iv_testmode.
    mtr_objek               = itr_objek.
    mv_log2file             = iv_log2file.
    mo_conv_util            = cl_ngc_core_conv_util=>get_instance( ).
    mo_conv_logger          = cl_ngc_core_conv_logger=>get_instance( ).
    mo_pfw_util             = cl_ngc_core_conv_pfw_util=>get_instance( ).

  ENDMETHOD.