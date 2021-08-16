  METHOD on_link_click.

    DATA: lx_error TYPE REF TO zcx_abapgit_exception.
    FIELD-SYMBOLS: <ls_log> TYPE ty_log_out.

    IF row IS INITIAL
    OR column IS INITIAL.
      RETURN.
    ENDIF.

    READ TABLE gt_log ASSIGNING <ls_log>
                      INDEX row.
    ASSERT sy-subrc = 0.

    TRY.
        dispatch(
            is_log    = <ls_log>
            iv_column = column ).

      CATCH zcx_abapgit_exception INTO lx_error.
        MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.