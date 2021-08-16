METHOD get_characteristic.

  IF go_characteristic IS INITIAL.
    cl_rap_plmi_msg_convert=>get_mapper(
      IMPORTING
        eo_mapper_symsg = DATA(lo_sy_msg_convert)
        eo_mapper_bapi  = DATA(lo_bapi_msg_convert) ).

    go_characteristic = NEW cl_ngc_bil_chr(
      io_sy_msg_convert       = lo_sy_msg_convert
      io_bapi_message_convert = lo_bapi_msg_convert
      io_vdm_api_mapper       = NEW cl_vdm_plmb_api_mapper_chr( )
      io_chr_bapi_util        = NEW cl_ngc_rap_chr_bapi_util( ) ).
  ENDIF.

  ro_characteristic = go_characteristic.

ENDMETHOD.