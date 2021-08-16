  METHOD zif_abapgit_object~delete.

    DATA: lx_error TYPE REF TO cx_swb_exception.

    TRY.
        mi_persistence->delete( mv_service_binding_key ).

      CATCH cx_swb_exception INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.