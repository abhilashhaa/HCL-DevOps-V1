  METHOD warning_overwrite_find.

    DATA: ls_overwrite LIKE LINE OF rt_overwrite.

    FIELD-SYMBOLS: <ls_result> LIKE LINE OF it_results.

    LOOP AT it_results ASSIGNING <ls_result> WHERE NOT obj_type IS INITIAL.
      IF <ls_result>-lstate IS NOT INITIAL
        AND NOT ( <ls_result>-lstate = zif_abapgit_definitions=>c_state-added
        AND <ls_result>-rstate IS INITIAL ).
        " current object has been modified or deleted locally, add to table
        CLEAR ls_overwrite.
        MOVE-CORRESPONDING <ls_result> TO ls_overwrite.
        APPEND ls_overwrite TO rt_overwrite.
      ENDIF.
    ENDLOOP.

    SORT rt_overwrite.
    DELETE ADJACENT DUPLICATES FROM rt_overwrite.

  ENDMETHOD.