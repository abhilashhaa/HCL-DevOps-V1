  METHOD run_performance_test.
    DATA: lo_performance                TYPE REF TO zcl_abapgit_performance_test,
          lv_package                    TYPE devclass,
          lv_include_sub_packages       TYPE abap_bool VALUE abap_true,
          lv_serialize_master_lang_only TYPE abap_bool VALUE abap_true,
          lt_object_type_filter         TYPE zif_abapgit_definitions=>ty_object_type_range,
          lt_object_name_filter         TYPE zif_abapgit_definitions=>ty_object_name_range,
          lt_result                     TYPE zcl_abapgit_performance_test=>gty_result_tab,
          lo_alv                        TYPE REF TO cl_salv_table,
          lx_salv_error                 TYPE REF TO cx_salv_error,
          lv_current_repo               TYPE zif_abapgit_persistence=>ty_value,
          lo_runtime_column             TYPE REF TO cl_salv_column,
          lo_seconds_column             TYPE REF TO cl_salv_column,
          li_popups                     TYPE REF TO zif_abapgit_popups.

    TRY.
        lv_current_repo = zcl_abapgit_persistence_user=>get_instance( )->get_repo_show( ).
        IF lv_current_repo IS NOT INITIAL.
          lv_package = zcl_abapgit_repo_srv=>get_instance( )->get( lv_current_repo )->get_package( ).
        ENDIF.
      CATCH zcx_abapgit_exception ##NO_HANDLER.
    ENDTRY.

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    li_popups->popup_perf_test_parameters(
      IMPORTING
        et_object_type_filter         = lt_object_type_filter
        et_object_name_filter         = lt_object_name_filter
      CHANGING
        cv_package                    = lv_package
        cv_include_sub_packages       = lv_include_sub_packages
        cv_serialize_master_lang_only = lv_serialize_master_lang_only ).

    CREATE OBJECT lo_performance
      EXPORTING
        iv_package                    = lv_package
        iv_include_sub_packages       = lv_include_sub_packages
        iv_serialize_master_lang_only = lv_serialize_master_lang_only.


    lo_performance->set_object_type_filter( lt_object_type_filter ).
    lo_performance->set_object_name_filter( lt_object_name_filter ).

    lo_performance->run_measurement( ).

    lt_result = lo_performance->get_result( ).

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_alv
          CHANGING
            t_table      = lt_result ).
        lo_alv->get_functions( )->set_all( ).
        lo_alv->get_display_settings( )->set_list_header( 'Serialization Performance Test Results' ).
        lo_runtime_column = lo_alv->get_columns( )->get_column( 'RUNTIME' ).
        lo_runtime_column->set_medium_text( 'Runtime' ).
        lo_runtime_column->set_visible( abap_false ).
        lo_seconds_column = lo_alv->get_columns( )->get_column( 'SECONDS' ).
        lo_seconds_column->set_medium_text( 'Seconds' ).
        lo_alv->get_columns( )->set_count_column( 'COUNTER' ).
        lo_alv->get_aggregations( )->add_aggregation( lo_runtime_column->get_columnname( ) ).
        lo_alv->get_aggregations( )->add_aggregation( lo_seconds_column->get_columnname( ) ).
        lo_alv->set_screen_popup(
          start_column = 1
          end_column   = 180
          start_line   = 1
          end_line     = 25 ).
        lo_alv->display( ).
      CATCH cx_salv_error INTO lx_salv_error.
        zcx_abapgit_exception=>raise(
          iv_text     = lx_salv_error->get_text( )
          ix_previous = lx_salv_error ).
    ENDTRY.
  ENDMETHOD.