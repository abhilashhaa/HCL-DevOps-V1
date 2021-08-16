  METHOD calculate_diff.

    DATA: lt_remote TYPE zif_abapgit_definitions=>ty_files_tt,
          lt_local  TYPE zif_abapgit_definitions=>ty_files_item_tt,
          lt_status TYPE zif_abapgit_definitions=>ty_results_tt.

    FIELD-SYMBOLS: <ls_status> LIKE LINE OF lt_status.

    CLEAR: mt_diff_files.

    lt_remote = mo_repo->get_files_remote( ).
    lt_local  = mo_repo->get_files_local( ).
    mo_repo->reset_status( ).
    lt_status = mo_repo->status( ).

    IF is_file IS NOT INITIAL.        " Diff for one file

      READ TABLE lt_status ASSIGNING <ls_status>
        WITH KEY path = is_file-path filename = is_file-filename.

      append_diff( it_remote = lt_remote
                   it_local  = lt_local
                   is_status = <ls_status> ).

    ELSEIF is_object IS NOT INITIAL.  " Diff for whole object

      LOOP AT lt_status ASSIGNING <ls_status>
          WHERE obj_type = is_object-obj_type
          AND obj_name = is_object-obj_name
          AND match IS INITIAL.
        append_diff( it_remote = lt_remote
                     it_local  = lt_local
                     is_status = <ls_status> ).
      ENDLOOP.

    ELSE.                             " Diff for the whole repo

      SORT lt_status BY
        path ASCENDING
        filename ASCENDING.
      LOOP AT lt_status ASSIGNING <ls_status> WHERE match IS INITIAL.
        append_diff( it_remote = lt_remote
                     it_local  = lt_local
                     is_status = <ls_status> ).
      ENDLOOP.

    ENDIF.

    filter_diff_by_files(
      EXPORTING
        it_files      = it_files
      CHANGING
        ct_diff_files = mt_diff_files ).

  ENDMETHOD.