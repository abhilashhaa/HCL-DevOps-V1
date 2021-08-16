  METHOD zif_abapgit_object~deserialize.

    DATA: ls_badi_definition             TYPE badi_data,
          lo_filter_object               TYPE REF TO cl_badi_flt_struct,
          lo_filter_values_object        TYPE REF TO cl_badi_flt_values_alv,
          lv_korrnum                     TYPE trkorr,
          lv_filter_type_enhanceability  TYPE rsexscrn-flt_ext,
          lv_package                     TYPE devclass,
          ls_classic_badi_implementation TYPE ty_classic_badi_implementation.

    io_xml->read(
      EXPORTING
        iv_name = 'SXCI'
      CHANGING
        cg_data = ls_classic_badi_implementation ).

    CALL FUNCTION 'SXO_BADI_READ'
      EXPORTING
        exit_name    = ls_classic_badi_implementation-implementation_data-exit_name
      IMPORTING
        badi         = ls_badi_definition
        filter_obj   = lo_filter_object
      EXCEPTIONS
        read_failure = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_BADI_READ' ).
    ENDIF.

    lv_package = iv_package.

    CREATE OBJECT lo_filter_values_object
      EXPORTING
        filter_object = lo_filter_object
        filter_values = ls_classic_badi_implementation-filters.

    CALL FUNCTION 'SXO_IMPL_SAVE'
      EXPORTING
        impl             = ls_classic_badi_implementation-implementation_data
        flt_ext          = lv_filter_type_enhanceability
        filter_val_obj   = lo_filter_values_object
        genflag          = abap_true
        no_dialog        = abap_true
      TABLES
        fcodes_to_insert = ls_classic_badi_implementation-function_codes
        cocos_to_insert  = ls_classic_badi_implementation-control_composites
        intas_to_insert  = ls_classic_badi_implementation-customer_includes
        sscrs_to_insert  = ls_classic_badi_implementation-screens
      CHANGING
        korrnum          = lv_korrnum
        devclass         = lv_package
      EXCEPTIONS
        save_failure     = 1
        action_canceled  = 2
        OTHERS           = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_IMPL_SAVE' ).
    ENDIF.

    CALL FUNCTION 'SXO_IMPL_ACTIVE'
      EXPORTING
        imp_name                  = ls_classic_badi_implementation-implementation_data-imp_name
        no_dialog                 = abap_true
      EXCEPTIONS
        badi_not_existing         = 1
        imp_not_existing          = 2
        already_active            = 3
        data_inconsistency        = 4
        activation_not_admissable = 5
        action_canceled           = 6
        access_failure            = 7
        OTHERS                    = 8.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_IMPL_ACTIVE' ).
    ENDIF.

  ENDMETHOD.