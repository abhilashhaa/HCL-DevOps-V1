  METHOD SETUP.

    DATA:
      lo_msg_convert   TYPE REF TO if_rap_plmi_sy_msg_convert,
      lo_bapi_msg_convert   TYPE REF TO if_rap_plmi_bapi_msg_convert,
      lo_chr_bapi_util TYPE REF TO if_ngc_rap_chr_bapi_util.


    go_sql_environment->clear_doubles( ).

    lo_msg_convert      ?= cl_abap_testdouble=>create( 'if_rap_plmi_sy_msg_convert' ).
    lo_bapi_msg_convert ?= cl_abap_testdouble=>create( 'if_rap_plmi_bapi_msg_convert' ).
    lo_chr_bapi_util    ?= cl_abap_testdouble=>create( 'if_ngc_rap_chr_bapi_util' ).

    cl_abap_testdouble=>configure_call( lo_chr_bapi_util
      )->ignore_all_parameters(
      )->returning( 2 ).
    lo_chr_bapi_util->read_currency_decimals( '' ).

    cl_abap_testdouble=>configure_call( lo_chr_bapi_util )->returning( th_ngc_bil_chr_data=>cv_keydate_2017 ).
    lo_chr_bapi_util->read_change_number_valid_from( th_ngc_bil_chr_data=>cv_changenumber_2017 ).

    cl_abap_testdouble=>configure_call( lo_chr_bapi_util )->returning( th_ngc_bil_chr_data=>cv_keydate_2018 ).
    lo_chr_bapi_util->read_change_number_valid_from( th_ngc_bil_chr_data=>cv_changenumber_2018 ).

    cl_abap_testdouble=>configure_call( lo_chr_bapi_util )->returning( th_ngc_bil_chr_data=>cv_keydate_2019 ).
    lo_chr_bapi_util->read_change_number_valid_from( th_ngc_bil_chr_data=>cv_changenumber_2019 ).

    mo_cut = NEW cl_ngc_bil_chr(
      io_sy_msg_convert       = lo_msg_convert
      io_bapi_message_convert = lo_bapi_msg_convert
      io_vdm_api_mapper       = NEW cl_vdm_plmb_api_mapper_chr( )
      io_chr_bapi_util        = lo_chr_bapi_util ).

  ENDMETHOD.