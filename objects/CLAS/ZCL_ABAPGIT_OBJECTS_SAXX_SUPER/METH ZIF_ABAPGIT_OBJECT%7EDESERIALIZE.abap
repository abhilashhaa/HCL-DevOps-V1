  METHOD zif_abapgit_object~deserialize.

    DATA: lr_data TYPE REF TO data.

    FIELD-SYMBOLS: <lg_data> TYPE any.

    create_channel_objects( ).

    TRY.
        CREATE DATA lr_data TYPE (mv_data_structure_name).
        ASSIGN lr_data->* TO <lg_data>.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |{ ms_item-obj_type } not supported| ).
    ENDTRY.

    io_xml->read(
      EXPORTING
        iv_name = ms_item-obj_type
      CHANGING
        cg_data = <lg_data> ).

    IF zif_abapgit_object~exists( ) = abap_true.
      zif_abapgit_object~delete( iv_package ).
    ENDIF.

    TRY.
        lock( ).

        CALL FUNCTION 'RS_CORR_INSERT'
          EXPORTING
            object              = ms_item-obj_name
            object_class        = ms_item-obj_type
            mode                = 'I'
            global_lock         = abap_true
            devclass            = iv_package
            master_language     = mv_language
            suppress_dialog     = abap_true
          EXCEPTIONS
            cancelled           = 1
            permission_failure  = 2
            unknown_objectclass = 3
            OTHERS              = 4.

        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( |Error occured while creating { ms_item-obj_type }| ).
        ENDIF.

        mi_appl_obj_data->set_data( <lg_data> ).

        mi_persistence->save( mi_appl_obj_data ).

        unlock( ).

      CATCH cx_swb_exception.
        zcx_abapgit_exception=>raise( |Error occured while creating { ms_item-obj_type }| ).
    ENDTRY.

  ENDMETHOD.