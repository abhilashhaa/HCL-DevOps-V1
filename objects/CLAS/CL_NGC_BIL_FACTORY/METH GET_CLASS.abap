METHOD get_class.

  IF go_class IS INITIAL.
    cl_rap_plmi_msg_convert=>get_mapper(
      IMPORTING
        eo_mapper_symsg = DATA(lo_sy_msg_convert)
        eo_mapper_exc   = DATA(lo_exc_convert)
        eo_mapper_bapi  = DATA(lo_bapi_msg_convert) ).

    go_class = NEW cl_ngc_bil_cls(
      io_sy_msg_convert       = lo_sy_msg_convert
      io_bapi_message_convert = lo_bapi_msg_convert
      io_exc_message_convert  = lo_exc_convert
      io_vdm_api_mapper       = NEW cl_vdm_plmb_api_mapper_cls( )
      io_cls_bapi_util        = NEW cl_ngc_rap_cls_bapi_util( ) ).
  ENDIF.

  ro_class = go_class.

ENDMETHOD.