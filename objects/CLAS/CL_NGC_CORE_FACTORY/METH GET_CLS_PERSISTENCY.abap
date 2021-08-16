  METHOD get_cls_persistency.

    IF go_cls_persistency IS INITIAL.
      go_cls_persistency = NEW cl_ngc_core_cls_persistency(
        io_chr_persistency = get_chr_persistency( )
        io_util_intersect  = cl_ngc_core_cls_util_intersect=>get_instance( )
      ).
    ENDIF.

    ro_cls_persistency = go_cls_persistency.

  ENDMETHOD.