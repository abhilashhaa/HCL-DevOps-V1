  METHOD zif_abapgit_object~exists.

    DATA: lo_dcl   TYPE REF TO object,
          lx_error TYPE REF TO cx_root.

    TRY.
        CALL METHOD ('CL_ACM_DCL_HANDLER_FACTORY')=>('CREATE')
          RECEIVING
            ro_handler = lo_dcl.

        CALL METHOD lo_dcl->('CHECK_EXISTENCE')
          EXPORTING
            iv_objectname = ms_item-obj_name
          RECEIVING
            rv_exists     = rv_bool.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.