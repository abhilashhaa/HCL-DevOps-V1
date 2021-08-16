  METHOD setup.

    DATA:
      lo_msg_convert      TYPE REF TO if_rap_plmi_sy_msg_convert,
      lo_bapi_msg_convert TYPE REF TO if_rap_plmi_bapi_msg_convert,
      lo_exc_msg_convert  TYPE REF TO if_rap_plmi_exc_msg_convert,
      lo_cls_bapi_util    TYPE REF TO if_ngc_rap_cls_bapi_util.


    go_sql_environment->clear_doubles( ).

    lo_msg_convert      ?= cl_abap_testdouble=>create( 'if_rap_plmi_sy_msg_convert' ).
    lo_bapi_msg_convert ?= cl_abap_testdouble=>create( 'if_rap_plmi_bapi_msg_convert' ).
    lo_exc_msg_convert  ?= cl_abap_testdouble=>create( 'if_rap_plmi_exc_msg_convert' ).
    lo_cls_bapi_util    ?= cl_abap_testdouble=>create( 'if_ngc_rap_cls_bapi_util' ).

    mo_cut = NEW cl_ngc_bil_cls(
      io_sy_msg_convert       = lo_msg_convert
      io_bapi_message_convert = lo_bapi_msg_convert
      io_exc_message_convert  = lo_exc_msg_convert
      io_vdm_api_mapper       = NEW cl_vdm_plmb_api_mapper_cls( )
      io_cls_bapi_util        = lo_cls_bapi_util ).

    " data for test double
*    DATA(ls_existing_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class(
*       class           = th_ngc_bil_cls_data=>cs_class_existing-class
*       classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype
*       classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    ).
*    DATA(lt_existing_desc) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc(
*      ( classinternalid   = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        language          = th_ngc_bil_cls_data=>cs_classdesc_existing-language
*        classdescription  = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription )
*    ).
*    DATA(lt_existing_text) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext(
*      ( classinternalid   = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        language          = th_ngc_bil_cls_data=>cs_classdesc_existing-language
*        longtextid        = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00
*        classtext         = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 )
*      ( classinternalid   = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        language          = th_ngc_bil_cls_data=>cs_classdesc_existing-language
*        longtextid        = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_01
*        classtext         = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_01 )
*    ).
*    DATA(lt_existing_keyword) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword(
*      ( classinternalid            = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        language                   = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
*        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber
*        classkeywordtext           = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext
*      )
*    ).
*    DATA(lt_existing_classcharc) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc(
*      ( charcinternalid       = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
*        classinternalid       = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        characteristic        = th_ngc_bil_cls_data=>cs_charc_existing-characteristic
*        charcissearchrelevant = th_ngc_bil_cls_data=>cs_classcharc_existing-charcissearchrelevant )
*    ).
*    DATA(lt_existing_classtext_id) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext_id(
*      ( klart       = th_ngc_bil_cls_data=>cs_class_existing-classtype
*        txida       = th_ngc_bil_cls_data=>cs_classtext_id-textblock
*        txidb       = th_ngc_bil_cls_data=>cs_classtext_id-texttype_00 )
*      ( klart       = th_ngc_bil_cls_data=>cs_class_existing-classtype
*        txida       = th_ngc_bil_cls_data=>cs_classtext_id-textblock
*        txidb       = th_ngc_bil_cls_data=>cs_classtext_id-texttype_01 )
*      ( klart       = th_ngc_bil_cls_data=>cs_class_existing-classtype
*        txida       = th_ngc_bil_cls_data=>cs_classtext_id-textblock
*        txidb       = th_ngc_bil_cls_data=>cs_classtext_id-texttype_02 )
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value =  ls_existing_class ).
*
*    lo_cls_bapi_util->single_class_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        iv_keydate         = sy-datum
*    ).
*
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value =  lt_existing_desc ).
*
*    lo_cls_bapi_util->classdesc_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        iv_keydate         = sy-datum
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value =  lt_existing_keyword ).
*    lo_cls_bapi_util->classkeyword_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        iv_keydate         = sy-datum
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value =  lt_existing_text ).
*    lo_cls_bapi_util->classtext_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        iv_keydate         = sy-datum
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value =  lt_existing_classcharc ).
*    lo_cls_bapi_util->classcharc_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*        iv_keydate         = sy-datum
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSTYPE'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classtype
*    )->returning( value =  lt_existing_classtext_id ).
*    lo_cls_bapi_util->classtext_id(
*      EXPORTING
*        iv_classtype = th_ngc_bil_cls_data=>cs_class_existing-classtype
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CHARCINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classtype
*    )->returning( value =  th_ngc_bil_cls_data=>cs_charc_new-characteristic ).
*    lo_cls_bapi_util->get_characteristic(
*      EXPORTING
*        iv_charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_new-charcinternalid
*    ).
*
*    "existing charateristic
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CHARACTERISTIC'
*        value         = th_ngc_bil_cls_data=>cs_charc_existing-characteristic
*    )->returning( value =  th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ).
*    lo_cls_bapi_util->get_charcinternalid(
*      EXPORTING
*        iv_characteristic = th_ngc_bil_cls_data=>cs_charc_existing-characteristic
*    ).
*    "new characteristic
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CHARACTERISTIC'
*        value         = th_ngc_bil_cls_data=>cs_charc_new-characteristic
*    )->returning( value =  th_ngc_bil_cls_data=>cs_charc_new-charcinternalid ).
*    lo_cls_bapi_util->get_charcinternalid(
*      EXPORTING
*        iv_characteristic = th_ngc_bil_cls_data=>cs_charc_new-characteristic
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASS'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-class
*    )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSTYPE'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classtype
*    )->returning( value =  ls_existing_class ).
*    lo_cls_bapi_util->single_class_by_ext_id(
*      EXPORTING
*        iv_class      = th_ngc_bil_cls_data=>cs_class_existing-class
*        iv_classtype  = th_ngc_bil_cls_data=>cs_class_existing-classtype
*    ).
*
*    cl_abap_testdouble=>configure_call( double = lo_cls_bapi_util )->set_parameter(
*      EXPORTING
*        name          = 'IV_CLASSINTERNALID'
*        value         = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    )->returning( value = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_class( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).
*    lo_cls_bapi_util->single_class_by_int_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    ).
*    lo_cls_bapi_util->check_class_exists_by_id(
*      EXPORTING
*        iv_classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
*    ).

  ENDMETHOD.