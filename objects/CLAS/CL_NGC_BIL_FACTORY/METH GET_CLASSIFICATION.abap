METHOD get_classification.

  IF go_classification IS INITIAL.
    cl_rap_plmi_msg_convert=>get_mapper(
      IMPORTING
        eo_mapper_symsg = DATA(lo_sy_msg_convert) ).
    go_classification = NEW cl_ngc_bil_clf(
      io_ngc_api        = cl_ngc_api_factory=>get_instance( )->get_api( )
      io_sy_msg_convert = lo_sy_msg_convert ).
  ENDIF.

  ro_classification = go_classification.

ENDMETHOD.