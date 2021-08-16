  METHOD run.

    DATA: lt_asource TYPE ty_ancestor_tt,
          lt_atarget TYPE ty_ancestor_tt.

    CLEAR: ms_merge, mt_objects, mt_conflicts.

    ms_merge-repo = mo_repo.
    mt_objects = fetch_git( ).

    lt_asource = find_ancestors( ms_merge-source-sha1 ).
    lt_atarget = find_ancestors( ms_merge-target-sha1 ).

    ms_merge-common = find_first_common( it_list1 = lt_asource
                                         it_list2 = lt_atarget ).

    ms_merge-stree = zcl_abapgit_git_porcelain=>full_tree(
      it_objects = mt_objects
      iv_branch  = ms_merge-source-sha1 ).
    ms_merge-ttree = zcl_abapgit_git_porcelain=>full_tree(
      it_objects = mt_objects
      iv_branch  = ms_merge-target-sha1 ).
    ms_merge-ctree = zcl_abapgit_git_porcelain=>full_tree(
      it_objects = mt_objects
      iv_branch  = ms_merge-common-commit ).

    calculate_result( ).

  ENDMETHOD.