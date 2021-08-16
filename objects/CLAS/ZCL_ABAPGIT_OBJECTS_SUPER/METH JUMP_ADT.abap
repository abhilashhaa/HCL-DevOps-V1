  METHOD jump_adt.

    DATA: lv_adt_link TYPE string,
          lx_error    TYPE REF TO cx_root.

    TRY.

        lv_adt_link = zcl_abapgit_adt_link=>generate(
          iv_obj_name     = iv_obj_name
          iv_obj_type     = iv_obj_type
          iv_sub_obj_name = iv_sub_obj_name
          iv_line_number  = iv_line_number ).

        cl_gui_frontend_services=>execute(
          EXPORTING  document = lv_adt_link
          EXCEPTIONS OTHERS   = 1 ).

        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( |ADT Jump Error - failed to open link { lv_adt_link }. Subrc={ sy-subrc }| ).
        ENDIF.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text = 'ADT Jump Error'
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.