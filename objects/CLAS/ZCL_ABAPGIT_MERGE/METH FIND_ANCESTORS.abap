  METHOD find_ancestors.

    DATA: ls_commit TYPE zcl_abapgit_git_pack=>ty_commit,
          lt_visit  TYPE ty_visit_tt,
          lv_commit LIKE LINE OF lt_visit.

    FIELD-SYMBOLS: <ls_ancestor> LIKE LINE OF rt_ancestors,
                   <ls_object>   LIKE LINE OF mt_objects.


    APPEND iv_commit TO lt_visit.

    LOOP AT lt_visit INTO lv_commit.
      READ TABLE mt_objects ASSIGNING <ls_object>
        WITH KEY type COMPONENTS
          type = zif_abapgit_definitions=>c_type-commit
          sha1 = lv_commit.
      ASSERT sy-subrc = 0.

      ls_commit = zcl_abapgit_git_pack=>decode_commit( <ls_object>-data ).

      visit( EXPORTING iv_parent = ls_commit-parent
             CHANGING ct_visit   = lt_visit ).
      visit( EXPORTING iv_parent = ls_commit-parent2
             CHANGING ct_visit   = lt_visit ).

      APPEND INITIAL LINE TO rt_ancestors ASSIGNING <ls_ancestor>.
      <ls_ancestor>-commit = lv_commit.
      <ls_ancestor>-tree = ls_commit-tree.
      <ls_ancestor>-body = ls_commit-body.
      <ls_ancestor>-time = ls_commit-author.

      "Strip Author entry of all but the time component
      REPLACE ALL OCCURRENCES OF REGEX '[a-zA-Z<>@.-]*' IN <ls_ancestor>-time WITH ''.
      CONDENSE <ls_ancestor>-time.
    ENDLOOP.

    SORT rt_ancestors BY time DESCENDING.

  ENDMETHOD.