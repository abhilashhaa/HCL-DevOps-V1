  METHOD zif_abapgit_object~serialize.

    DATA: lv_object_key  TYPE seu_objkey,
          li_data_model  TYPE REF TO if_wb_object_data_model,
          li_persistence TYPE REF TO if_wb_object_persist,
          lr_data        TYPE REF TO data,
          lx_error       TYPE REF TO cx_root.

    FIELD-SYMBOLS: <lg_data>  TYPE any,
                   <lg_field> TYPE data.

    lv_object_key = ms_item-obj_name.

    TRY.
        CREATE DATA lr_data
          TYPE ('CL_DDLX_WB_OBJECT_DATA=>TY_OBJECT_DATA').
        ASSIGN lr_data->* TO <lg_data>.

        CREATE OBJECT li_data_model
          TYPE ('CL_DDLX_WB_OBJECT_DATA').

        li_persistence = get_persistence( ).

        IF zcl_abapgit_factory=>get_environment( )->compare_with_inactive( ) = abap_true.
          "Retrieve inactive version
          li_persistence->get(
            EXPORTING
              p_object_key  = lv_object_key
              p_version     = swbm_version_inactive
            CHANGING
              p_object_data = li_data_model ).
          IF li_data_model->get_object_name( ) IS INITIAL.
            "Fallback: retrieve active version
            li_persistence->get(
              EXPORTING
                p_object_key  = lv_object_key
                p_version     = swbm_version_active
              CHANGING
                p_object_data = li_data_model ).
          ENDIF.
        ELSE.
          "Retrieve active version
          li_persistence->get(
            EXPORTING
              p_object_key  = lv_object_key
              p_version     = swbm_version_active
            CHANGING
              p_object_data = li_data_model ).
        ENDIF.

        li_data_model->get_data( IMPORTING p_data = <lg_data> ).

        clear_fields( CHANGING cg_data = <lg_data> ).

        ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.

        mo_files->add_string( iv_ext    = 'asddlxs'
                              iv_string = <lg_field> ).

        CLEAR <lg_field>.

        io_xml->add( iv_name = 'DDLX'
                     ig_data = <lg_data> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error->previous ).
    ENDTRY.

  ENDMETHOD.