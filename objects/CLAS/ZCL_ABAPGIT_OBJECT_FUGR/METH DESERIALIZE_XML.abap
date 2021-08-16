  METHOD deserialize_xml.

    DATA: lv_complete     TYPE rs38l-area,
          lv_namespace    TYPE rs38l-namespace,
          lv_areat        TYPE tlibt-areat,
          lv_stext        TYPE tftit-stext,
          lv_group        TYPE rs38l-area,
          lv_abap_version TYPE trdir-uccheck,
          lv_corrnum      TYPE e070use-ordernum.

    lv_abap_version = get_abap_version( ii_xml ).
    lv_complete = ms_item-obj_name.

    CALL FUNCTION 'FUNCTION_INCLUDE_SPLIT'
      EXPORTING
        complete_area                = lv_complete
      IMPORTING
        namespace                    = lv_namespace
        group                        = lv_group
      EXCEPTIONS
        include_not_exists           = 1
        group_not_exists             = 2
        no_selections                = 3
        no_function_include          = 4
        no_function_pool             = 5
        delimiter_wrong_position     = 6
        no_customer_function_group   = 7
        no_customer_function_include = 8
        reserved_name_customer       = 9
        namespace_too_long           = 10
        area_length_error            = 11
        OTHERS                       = 12.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from FUNCTION_INCLUDE_SPLIT' ).
    ENDIF.

    ii_xml->read( EXPORTING iv_name = 'AREAT'
                  CHANGING cg_data = lv_areat ).
    lv_stext = lv_areat.
    lv_corrnum = zcl_abapgit_default_transport=>get_instance( )->get( )-ordernum.

    CALL FUNCTION 'RS_FUNCTION_POOL_INSERT'
      EXPORTING
        function_pool           = lv_group
        short_text              = lv_stext
        namespace               = lv_namespace
        devclass                = iv_package
        unicode_checks          = lv_abap_version
        corrnum                 = lv_corrnum
        suppress_corr_check     = abap_false
      EXCEPTIONS
        name_already_exists     = 1
        name_not_correct        = 2
        function_already_exists = 3
        invalid_function_pool   = 4
        invalid_name            = 5
        too_many_functions      = 6
        no_modify_permission    = 7
        no_show_permission      = 8
        enqueue_system_failure  = 9
        canceled_in_corr        = 10
        undefined_error         = 11
        OTHERS                  = 12.

    CASE sy-subrc.
      WHEN 0.
        " Everything is ok
      WHEN 1 OR 3.
        " If the function group exists we need to manually update the short text
        update_func_group_short_text( iv_group      = lv_group
                                      iv_short_text = lv_stext ).
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |error from RS_FUNCTION_POOL_INSERT, code: { sy-subrc }| ).
    ENDCASE.

  ENDMETHOD.