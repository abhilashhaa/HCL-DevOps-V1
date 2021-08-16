  METHOD zif_abapgit_code_inspector~run.

    DATA: lo_set     TYPE REF TO cl_ci_objectset,
          lo_variant TYPE REF TO cl_ci_checkvariant,
          lx_error   TYPE REF TO zcx_abapgit_exception.


    TRY.
        lo_set = create_objectset( ).

        IF lines( lo_set->iobjlst-objects ) = 0.
          " no objects, nothing to check
          RETURN.
        ENDIF.

        lo_variant = create_variant( iv_variant ).

        mo_inspection = create_inspection(
          io_set     = lo_set
          io_variant = lo_variant ).

        rt_list = run_inspection( mo_inspection ).

        cleanup( lo_set ).

        IF iv_save = abap_true.
          READ TABLE rt_list TRANSPORTING NO FIELDS WITH KEY kind = 'E'.
          mv_success = boolc( sy-subrc <> 0 ).
        ENDIF.

      CATCH zcx_abapgit_exception INTO lx_error.

        " ensure cleanup
        cleanup( lo_set ).
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).

    ENDTRY.

  ENDMETHOD.