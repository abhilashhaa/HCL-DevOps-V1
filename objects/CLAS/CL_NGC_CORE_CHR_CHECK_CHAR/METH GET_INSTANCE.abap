  METHOD GET_INSTANCE.

    IF go_instance IS INITIAL.
      go_instance = NEW cl_ngc_core_chr_check_char( ).
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.