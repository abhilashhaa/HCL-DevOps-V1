  METHOD get_next_id.

* todo: Lock the complete persistence in order to prevent concurrent repo-creation
* however the current approach will most likely work in almost all cases

    DATA: lt_content TYPE zif_abapgit_persistence=>tt_content.

    FIELD-SYMBOLS: <ls_content> LIKE LINE OF lt_content.


    rv_next_repo_id = 1.

    lt_content = mo_db->list_by_type( zcl_abapgit_persistence_db=>c_type_repo ).
    LOOP AT lt_content ASSIGNING <ls_content>.
      IF <ls_content>-value >= rv_next_repo_id.
        rv_next_repo_id = <ls_content>-value + 1.
      ENDIF.
    ENDLOOP.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = rv_next_repo_id
      IMPORTING
        output = rv_next_repo_id.

  ENDMETHOD.