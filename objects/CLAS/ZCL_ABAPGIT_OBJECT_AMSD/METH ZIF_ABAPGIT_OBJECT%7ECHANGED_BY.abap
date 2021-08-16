  METHOD zif_abapgit_object~changed_by.

    DATA:
      li_wb_object_operator TYPE REF TO object,
      li_object_data_model  TYPE REF TO if_wb_object_data_model,
      lx_error              TYPE REF TO cx_root.

    TRY.
        li_wb_object_operator = get_wb_object_operator( ).

        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~READ')
          IMPORTING
            eo_object_data = li_object_data_model.

        rv_user = li_object_data_model->get_changed_by( ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.