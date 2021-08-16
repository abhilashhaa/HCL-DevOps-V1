  METHOD get_persistence.

    DATA: lx_error TYPE REF TO cx_root.

    TRY.
        IF mi_persistence IS NOT BOUND.

          CREATE OBJECT mi_persistence
                 TYPE ('CL_DDLX_ADT_OBJECT_PERSIST').

        ENDIF.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

    ri_persistence = mi_persistence.

  ENDMETHOD.