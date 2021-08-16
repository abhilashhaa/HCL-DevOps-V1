  METHOD get_chr_persistency.

    IF go_chr_persistency IS INITIAL.
      go_chr_persistency = NEW cl_ngc_core_chr_persistency(
        io_chr_util_chcktable = cl_ngc_core_chr_util_chcktable=>get_instance( )
        io_core_util          = cl_ngc_core_util=>get_instance( )
        io_chr_util_funcmod   = cl_ngc_core_chr_util_funcmod=>get_instance( )
      ).
    ENDIF.

    ro_chr_persistency = go_chr_persistency.

  ENDMETHOD.