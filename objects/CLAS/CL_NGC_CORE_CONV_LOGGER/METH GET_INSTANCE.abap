  METHOD get_instance.

    IF go_instance IS INITIAL.
      go_instance = NEW cl_ngc_core_conv_logger( ).
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.