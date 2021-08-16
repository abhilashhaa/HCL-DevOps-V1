  METHOD is_any_function_module_locked.

    DATA: lt_functions TYPE ty_rs38l_incl_tt.

    FIELD-SYMBOLS: <ls_function> TYPE rs38l_incl.

    TRY.
        lt_functions = functions( ).
      CATCH zcx_abapgit_exception.
        RETURN.
    ENDTRY.

    LOOP AT lt_functions ASSIGNING <ls_function>.

      IF exists_a_lock_entry_for( iv_lock_object = 'ESFUNCTION'
                                  iv_argument    = |{ <ls_function>-funcname }| ) = abap_true.
        rv_any_function_module_locked = abap_true.
        EXIT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.