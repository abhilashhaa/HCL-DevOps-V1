  METHOD determine_branch.

    CONSTANTS: lc_head TYPE string VALUE 'HEAD'.

    TYPES: BEGIN OF ty_branch_with_time,
             time TYPE string,
             name TYPE string,
             sha1 TYPE zif_abapgit_definitions=>ty_sha1,
           END OF ty_branch_with_time.

    DATA: lt_branches_sorted_by_time TYPE SORTED TABLE OF ty_branch_with_time WITH NON-UNIQUE KEY time,
          ls_branches_with_time      TYPE ty_branch_with_time.

    FIELD-SYMBOLS: <ls_branch>                LIKE LINE OF mt_branches,
                   <ls_branch_sorted_by_time> LIKE LINE OF lt_branches_sorted_by_time,
                   <ls_head>                  LIKE LINE OF mt_branches,
                   <ls_commit>                LIKE LINE OF mt_commits,
                   <ls_create>                LIKE LINE OF <ls_commit>-create.


* Exchange HEAD, and make sure the branch determination starts with the HEAD branch
    READ TABLE mt_branches ASSIGNING <ls_head> WITH KEY name = lc_head.
    ASSERT sy-subrc = 0.
    LOOP AT mt_branches ASSIGNING <ls_branch>
        WHERE sha1 = <ls_head>-sha1 AND name <> lc_head.
      <ls_head>-name = <ls_branch>-name.
      DELETE mt_branches INDEX sy-tabix.
      EXIT.
    ENDLOOP.

* Sort Branches by Commit Time
    LOOP AT mt_branches ASSIGNING <ls_branch>.

      READ TABLE mt_commits ASSIGNING <ls_commit> WITH KEY sha1 = <ls_branch>-sha1.
      IF sy-subrc = 0.

        ls_branches_with_time-name = <ls_branch>-name+11.
        ls_branches_with_time-sha1 = <ls_branch>-sha1.

        IF <ls_branch>-is_head = abap_true.
          ls_branches_with_time-time = '0000000000'. "Force HEAD to be the first one
        ELSE.
          ls_branches_with_time-time = <ls_commit>-time.
        ENDIF.

        INSERT ls_branches_with_time INTO TABLE lt_branches_sorted_by_time.
        CLEAR ls_branches_with_time.

      ENDIF.
    ENDLOOP.


    LOOP AT lt_branches_sorted_by_time ASSIGNING <ls_branch_sorted_by_time>.

      READ TABLE mt_commits ASSIGNING <ls_commit> WITH KEY sha1 = <ls_branch_sorted_by_time>-sha1.
      ASSERT sy-subrc = 0.

      DO.
        IF <ls_commit>-branch IS INITIAL.
          <ls_commit>-branch = <ls_branch_sorted_by_time>-name.
        ELSE.
          APPEND INITIAL LINE TO <ls_commit>-create ASSIGNING <ls_create>.
          <ls_create>-name = <ls_branch_sorted_by_time>-name.
          <ls_create>-parent = <ls_commit>-branch.
          EXIT.
        ENDIF.

        IF <ls_commit>-parent1 IS INITIAL.
          EXIT.
        ELSE.
          READ TABLE mt_commits ASSIGNING <ls_commit>
              WITH KEY sha1 = <ls_commit>-parent1.
          ASSERT sy-subrc = 0.
        ENDIF.
      ENDDO.

    ENDLOOP.

  ENDMETHOD.