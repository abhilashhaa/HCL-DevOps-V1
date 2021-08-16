  METHOD zif_abapgit_object~serialize.

    DATA: lv_implementation_name         TYPE rsexscrn-imp_name,
          lv_exit_name                   TYPE rsexscrn-exit_name,
          lo_filter_object               TYPE REF TO cl_badi_flt_struct,
          ls_badi_definition             TYPE badi_data,
          lo_filter_values_object        TYPE REF TO cl_badi_flt_values_alv,
          lt_methods                     TYPE seex_mtd_table,
          ls_classic_badi_implementation TYPE ty_classic_badi_implementation.

    lv_implementation_name = ms_item-obj_name.

    CALL FUNCTION 'SXV_EXIT_FOR_IMP'
      EXPORTING
        imp_name           = lv_implementation_name
      IMPORTING
        exit_name          = lv_exit_name
      TABLES
        filters            = ls_classic_badi_implementation-filters
      EXCEPTIONS
        data_inconsistency = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXV_EXIT_FOR_IMP' ).
    ENDIF.

    CALL FUNCTION 'SXO_BADI_READ'
      EXPORTING
        exit_name    = lv_exit_name
      IMPORTING
        badi         = ls_badi_definition
        filter_obj   = lo_filter_object
      TABLES
        fcodes       = ls_classic_badi_implementation-function_codes
        cocos        = ls_classic_badi_implementation-control_composites
        intas        = ls_classic_badi_implementation-customer_includes
        scrns        = ls_classic_badi_implementation-screens
        methods      = lt_methods
      EXCEPTIONS
        read_failure = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_BADI_READ' ).
    ENDIF.

    CALL FUNCTION 'SXO_IMPL_FOR_BADI_READ'
      EXPORTING
        imp_name                    = lv_implementation_name
        exit_name                   = lv_exit_name
        inter_name                  = ls_badi_definition-inter_name
        filter_obj                  = lo_filter_object
        no_create_filter_values_obj = abap_true
      IMPORTING
        impl                        = ls_classic_badi_implementation-implementation_data
        filter_values_obj           = lo_filter_values_object
      TABLES
        fcodes                      = ls_classic_badi_implementation-function_codes
        cocos                       = ls_classic_badi_implementation-control_composites
        intas                       = ls_classic_badi_implementation-customer_includes
        scrns                       = ls_classic_badi_implementation-screens
      CHANGING
        methods                     = lt_methods
      EXCEPTIONS
        read_failure                = 1
        OTHERS                      = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_IMPL_FOR_BADI_READ' ).
    ENDIF.

    CLEAR: ls_classic_badi_implementation-implementation_data-aname,
           ls_classic_badi_implementation-implementation_data-adate,
           ls_classic_badi_implementation-implementation_data-atime,
           ls_classic_badi_implementation-implementation_data-uname,
           ls_classic_badi_implementation-implementation_data-udate,
           ls_classic_badi_implementation-implementation_data-utime,
           ls_classic_badi_implementation-implementation_data-active.

    io_xml->add( iv_name = 'SXCI'
                 ig_data = ls_classic_badi_implementation ).

  ENDMETHOD.