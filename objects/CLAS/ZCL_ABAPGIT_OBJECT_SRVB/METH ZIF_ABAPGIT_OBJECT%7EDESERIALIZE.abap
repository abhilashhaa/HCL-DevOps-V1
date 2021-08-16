  METHOD zif_abapgit_object~deserialize.

    DATA:
      li_object_data_model TYPE REF TO if_wb_object_data_model,
      lx_error             TYPE REF TO cx_swb_exception,
      lv_access_mode       TYPE c LENGTH 8. " if_wb_adt_rest_resource_co=>ty_access_mode

    FIELD-SYMBOLS:
      <ls_service_binding> TYPE any,
      <lv_language>        TYPE data.

    ASSIGN mr_service_binding->* TO <ls_service_binding>.
    ASSERT sy-subrc = 0.

    io_xml->read(
      EXPORTING
        iv_name = 'SRVB'
      CHANGING
        cg_data = <ls_service_binding> ).

    TRY.
        IF zif_abapgit_object~exists( ) = abap_true.
          lv_access_mode = 'MODIFY'. " cl_wb_adt_rest_resource=>co_access_mode_modify
        ELSE.
          lv_access_mode = 'INSERT'. " cl_wb_adt_rest_resource=>co_access_mode_insert.
          tadir_insert( iv_package ).
        ENDIF.

        " We have to set the language explicitly,
        " because otherwise the description isn't stored
        ASSIGN COMPONENT 'METADATA-LANGUAGE' OF STRUCTURE <ls_service_binding>
               TO <lv_language>.
        ASSERT sy-subrc = 0.
        <lv_language> = mv_language.

        CREATE OBJECT li_object_data_model TYPE ('CL_SRVB_OBJECT_DATA').
        li_object_data_model->set_data( <ls_service_binding> ).

        CALL METHOD mi_persistence->('SAVE')
          EXPORTING
            p_object_data = li_object_data_model
            p_access_mode = lv_access_mode. " does not exist in 702

        corr_insert( iv_package ).

      CATCH cx_swb_exception INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.