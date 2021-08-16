  METHOD get_instance.

    IF go_instance IS INITIAL.
      go_instance = NEW cl_ngc_core_chr_check_date( if_ngc_c=>gc_charcdatatype-date ).
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.