  METHOD on_double_click.

    DATA: lx_error TYPE REF TO zcx_abapgit_exception.
    FIELD-SYMBOLS: <ls_callstack> TYPE abap_callstack_line.

    READ TABLE mt_callstack ASSIGNING <ls_callstack>
                            INDEX row.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    TRY.
        goto_source_code( <ls_callstack> ).

      CATCH zcx_abapgit_exception INTO lx_error.
        MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.