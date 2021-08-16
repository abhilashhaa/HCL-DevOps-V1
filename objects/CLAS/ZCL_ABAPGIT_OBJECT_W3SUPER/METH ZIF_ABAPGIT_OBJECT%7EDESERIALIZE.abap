  METHOD zif_abapgit_object~deserialize.

    DATA lv_base64str TYPE string.
    DATA lt_w3params  TYPE STANDARD TABLE OF wwwparams.
    DATA lv_xstring   TYPE xstring.
    DATA lt_w3mime    TYPE STANDARD TABLE OF w3mime.
    DATA lt_w3html    TYPE STANDARD TABLE OF w3html.
    DATA lv_size      TYPE i.
    DATA lv_tadir_obj TYPE tadir-object.


    io_xml->read( EXPORTING iv_name = 'TEXT'
                  CHANGING  cg_data = ms_key-text ).

    io_xml->read( EXPORTING iv_name = 'PARAMS'
                  CHANGING  cg_data = lt_w3params ).

    CASE io_xml->get_metadata( )-version.
      WHEN 'v1.0.0'.
        io_xml->read( EXPORTING iv_name = 'DATA'
                      CHANGING  cg_data = lv_base64str ).
        lv_xstring = cl_http_utility=>decode_x_base64( lv_base64str ).
      WHEN 'v2.0.0'.
        lv_xstring = zif_abapgit_object~mo_files->read_raw( iv_extra = 'data'
                                                    iv_ext   = get_ext( lt_w3params ) ).
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'W3xx: Unknown serializer version' ).
    ENDCASE.

    CASE ms_key-relid.
      WHEN 'MI'.
        CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
          EXPORTING
            buffer        = lv_xstring
          IMPORTING
            output_length = lv_size
          TABLES
            binary_tab    = lt_w3mime.
      WHEN 'HT'.
        CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
          EXPORTING
            buffer        = lv_xstring
          IMPORTING
            output_length = lv_size
          TABLES
            binary_tab    = lt_w3mime.

        CALL FUNCTION 'SCMS_BINARY_TO_TEXT'
          EXPORTING
            input_length  = lv_size
          IMPORTING
            output_length = lv_size
          TABLES
            binary_tab    = lt_w3mime
            text_tab      = lt_w3html
          EXCEPTIONS
            failed        = 1.
        IF sy-subrc IS NOT INITIAL.
          zcx_abapgit_exception=>raise( 'Cannot update W3xx params' ).
        ENDIF.

        CLEAR lt_w3mime.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'Wrong W3xx type' ).
    ENDCASE.

    " Update size of file based on actual data file size, prove param object name
    normalize_params( EXPORTING iv_size   = lv_size
                      CHANGING  ct_params = lt_w3params ).

    CALL FUNCTION 'WWWPARAMS_UPDATE'
      TABLES
        params       = lt_w3params
      EXCEPTIONS
        update_error = 1.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot update W3xx params' ).
    ENDIF.

    ms_key-tdate    = sy-datum.
    ms_key-ttime    = sy-uzeit.
    ms_key-chname   = sy-uname.
    ms_key-devclass = iv_package.

    CALL FUNCTION 'WWWDATA_EXPORT'
      EXPORTING
        key               = ms_key
      TABLES
        mime              = lt_w3mime
        html              = lt_w3html
      EXCEPTIONS
        wrong_object_type = 1
        export_error      = 2.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot upload W3xx data' ).
    ENDIF.

    CONCATENATE 'W3' ms_key-relid INTO lv_tadir_obj.

    CALL FUNCTION 'TR_TADIR_INTERFACE'
      EXPORTING
        wi_tadir_pgmid                 = 'R3TR'
        wi_tadir_object                = lv_tadir_obj
        wi_tadir_devclass              = iv_package
        wi_tadir_obj_name              = ms_key-objid
        wi_test_modus                  = space
      EXCEPTIONS
        tadir_entry_not_existing       = 1
        tadir_entry_ill_type           = 2
        no_systemname                  = 3
        no_systemtype                  = 4
        original_system_conflict       = 5
        object_reserved_for_devclass   = 6
        object_exists_global           = 7
        object_exists_local            = 8
        object_is_distributed          = 9
        obj_specification_not_unique   = 10
        no_authorization_to_delete     = 11
        devclass_not_existing          = 12
        simultanious_set_remove_repair = 13
        order_missing                  = 14
        no_modification_of_head_syst   = 15
        pgmid_object_not_allowed       = 16
        masterlanguage_not_specified   = 17
        devclass_not_specified         = 18
        specify_owner_unique           = 19
        loc_priv_objs_no_repair        = 20
        gtadir_not_reached             = 21
        object_locked_for_order        = 22
        change_of_class_not_allowed    = 23
        no_change_from_sap_to_tmp      = 24
        OTHERS                         = 99.
    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise( 'Cannot update TADIR for W3xx' ).
    ENDIF.

    corr_insert( iv_package ).

  ENDMETHOD.