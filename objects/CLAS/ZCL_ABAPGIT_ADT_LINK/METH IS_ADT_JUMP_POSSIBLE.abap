  METHOD is_adt_jump_possible.

    DATA: lo_wb_request         TYPE REF TO cl_wb_request,
          lo_adt_uri_mapper_vit TYPE REF TO object,
          lv_vit_wb_request     TYPE abap_bool.

    cl_wb_request=>create_from_object_ref(
      EXPORTING
        p_wb_object       = io_object
      RECEIVING
        p_wb_request      = lo_wb_request
      EXCEPTIONS
        illegal_operation = 1
        cancelled         = 2
        OTHERS            = 3 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
    ENDIF.

    TRY.
        CALL METHOD io_adt->('IF_ADT_TOOLS_CORE_FACTORY~GET_URI_MAPPER_VIT')
          RECEIVING
            result = lo_adt_uri_mapper_vit.

        CALL METHOD lo_adt_uri_mapper_vit->('IF_ADT_URI_MAPPER_VIT~IS_VIT_WB_REQUEST')
          EXPORTING
            wb_request = lo_wb_request
          RECEIVING
            result     = lv_vit_wb_request.

        rv_is_adt_jump_possible = boolc( NOT lv_vit_wb_request = abap_true ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
    ENDTRY.

  ENDMETHOD.