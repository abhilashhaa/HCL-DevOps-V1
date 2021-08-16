  METHOD get_package_from_adt.

    DATA: ls_item    TYPE zif_abapgit_definitions=>ty_item,
          lr_context TYPE REF TO data,
          lt_fields  TYPE tihttpnvp.


    FIELD-SYMBOLS: <lg_context>    TYPE any,
                   <lv_parameters> TYPE string,
                   <ls_field>      LIKE LINE OF lt_fields.

    ls_item-obj_type = 'CLAS'.
    ls_item-obj_name = 'CL_ADT_GUI_INTEGRATION_CONTEXT'.

    IF zcl_abapgit_objects=>exists( ls_item ) = abap_false.
      " ADT is not supported in this NW release
      RETURN.
    ENDIF.

    TRY.
        CREATE DATA lr_context TYPE ('CL_ADT_GUI_INTEGRATION_CONTEXT=>TY_CONTEXT_INFO').

        ASSIGN lr_context->* TO <lg_context>.
        ASSERT sy-subrc = 0.

        CALL METHOD ('CL_ADT_GUI_INTEGRATION_CONTEXT')=>read_context
          RECEIVING
            result = <lg_context>.

        ASSIGN COMPONENT 'PARAMETERS'
               OF STRUCTURE <lg_context>
               TO <lv_parameters>.
        ASSERT sy-subrc = 0.

        lt_fields = cl_http_utility=>string_to_fields( cl_http_utility=>unescape_url( <lv_parameters> ) ).

        READ TABLE lt_fields ASSIGNING <ls_field>
                             WITH KEY name = 'p_package_name'.
        IF sy-subrc = 0.
          rv_package = <ls_field>-value.

          " We want to open the repo just once. Therefore we delete the parameters
          " and initialize the ADT context.
          CLEAR <lv_parameters>.
          CALL METHOD ('CL_ADT_GUI_INTEGRATION_CONTEXT')=>initialize_instance
            EXPORTING
              context_info = <lg_context>.

        ENDIF.

      CATCH cx_root.
        " Some problems with dynamic ADT access.
        " Let's ignore it for now and fail silently
    ENDTRY.

  ENDMETHOD.