  METHOD get_clf_persistency.

    IF go_clf_persistency IS INITIAL.
      go_clf_persistency = NEW cl_ngc_core_clf_persistency(
        io_util            = cl_ngc_core_clf_util=>get_instance( )
        io_db_update       = cl_ngc_core_clf_db_update=>get_instance( )
        io_locking         = cl_ngc_core_clf_locking=>get_instance( )
        io_bte             = cl_ngc_core_clf_bte=>get_instance( )
        io_cls_persistency = get_cls_persistency( )
      ).
    ENDIF.

    ro_clf_persistency = go_clf_persistency.

  ENDMETHOD.