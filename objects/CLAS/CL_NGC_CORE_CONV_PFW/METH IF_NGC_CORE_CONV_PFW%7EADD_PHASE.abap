  METHOD if_ngc_core_conv_pfw~add_phase.

    mo_pfw->add_phase(
      iv_phase    = iv_phase
      ir_instance = ir_instance
      iv_method   = iv_method
      ir_params   = ir_params
    ).

  ENDMETHOD.