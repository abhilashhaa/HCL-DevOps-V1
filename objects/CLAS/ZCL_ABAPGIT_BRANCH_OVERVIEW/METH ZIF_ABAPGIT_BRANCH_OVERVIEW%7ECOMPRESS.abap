  METHOD zif_abapgit_branch_overview~compress.

    DATA: lv_previous TYPE i,
          lv_index    TYPE i,
          lv_name     TYPE string,
          lt_temp     LIKE it_commits.

    FIELD-SYMBOLS: <ls_branch> LIKE LINE OF mt_branches,
                   <ls_commit> LIKE LINE OF it_commits.

    LOOP AT mt_branches ASSIGNING <ls_branch>.

      CLEAR lt_temp.
      lv_name = <ls_branch>-name+11.

      LOOP AT it_commits ASSIGNING <ls_commit>
          WHERE branch = lv_name.
        lv_index = sy-tabix.

        IF NOT <ls_commit>-merge IS INITIAL
            OR NOT <ls_commit>-create IS INITIAL.
* always show these vertices
          lv_previous = -1.
        ENDIF.

        IF lv_previous + 1 <> sy-tabix.
          compress_internal(
            EXPORTING
              iv_name    = lv_name
            CHANGING
              ct_temp    = lt_temp
              ct_commits = rt_commits ).
        ENDIF.

        lv_previous = lv_index.

        APPEND <ls_commit> TO lt_temp.

      ENDLOOP.

      compress_internal(
        EXPORTING
          iv_name    = lv_name
        CHANGING
          ct_temp    = lt_temp
          ct_commits = rt_commits ).

    ENDLOOP.

    _sort_commits( CHANGING ct_commits = rt_commits ).

  ENDMETHOD.