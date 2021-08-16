  METHOD get_adt_objects_and_names.

    DATA lv_obj_type       TYPE trobjtype.
    DATA lv_obj_name       TYPE trobj_name.
    DATA lo_object         TYPE REF TO cl_wb_object.
    DATA lo_adt            TYPE REF TO object.
    FIELD-SYMBOLS <lv_uri> TYPE string.

    lv_obj_name = iv_obj_name.
    lv_obj_type = iv_obj_type.

    TRY.
        cl_wb_object=>create_from_transport_key(
          EXPORTING
            p_object    = lv_obj_type
            p_obj_name  = lv_obj_name
          RECEIVING
            p_wb_object = lo_object
          EXCEPTIONS
            OTHERS      = 1 ).
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
        ENDIF.

        CALL METHOD ('CL_ADT_TOOLS_CORE_FACTORY')=>('GET_INSTANCE')
          RECEIVING
            result = lo_adt.

        IF is_adt_jump_possible( io_object = lo_object
                                 io_adt    = lo_adt ) = abap_false.
          zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
        ENDIF.

        CALL METHOD lo_adt->('IF_ADT_TOOLS_CORE_FACTORY~GET_URI_MAPPER')
          RECEIVING
            result = eo_adt_uri_mapper.

        CALL METHOD eo_adt_uri_mapper->('IF_ADT_URI_MAPPER~MAP_WB_OBJECT_TO_OBJREF')
          EXPORTING
            wb_object = lo_object
          RECEIVING
            result    = eo_adt_objectref.

        ASSIGN ('EO_ADT_OBJECTREF->REF_DATA-URI') TO <lv_uri>.
        ASSERT sy-subrc = 0.

        CALL METHOD eo_adt_uri_mapper->('IF_ADT_URI_MAPPER~MAP_OBJREF_TO_INCLUDE')
          EXPORTING
            uri     = <lv_uri>
          IMPORTING
            program = ev_program
            include = ev_include.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
    ENDTRY.

  ENDMETHOD.