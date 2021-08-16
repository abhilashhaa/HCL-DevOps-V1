METHOD get_api.

  ro_api = NEW cl_ngc_api(
    io_api_factory        = cl_ngc_api_factory=>get_instance( )
    io_clf_persistency    = cl_ngc_core_factory=>get_clf_persistency( )
    io_cls_persistency    = cl_ngc_core_factory=>get_cls_persistency( )
    io_clf_validation_mgr = cl_ngc_clf_validation_mgr=>get_instance( )
    io_chr_persistency    = cl_ngc_core_factory=>get_chr_persistency( ) ).

ENDMETHOD.