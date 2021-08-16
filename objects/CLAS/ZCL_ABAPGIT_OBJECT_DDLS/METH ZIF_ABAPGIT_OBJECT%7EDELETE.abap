  METHOD zif_abapgit_object~delete.

    DATA: lo_ddl   TYPE REF TO object,
          lx_error TYPE REF TO cx_root.


    CALL METHOD ('CL_DD_DDL_HANDLER_FACTORY')=>('CREATE')
      RECEIVING
        handler = lo_ddl.

    TRY.
        CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~DELETE')
          EXPORTING
            name = ms_item-obj_name.
      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
          iv_text     = |DDLS, { ms_item-obj_name } { lx_error->get_text( ) }|
          ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.