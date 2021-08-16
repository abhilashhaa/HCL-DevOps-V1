  METHOD constructor.

    DATA: lt_objects TYPE zif_abapgit_definitions=>ty_objects_tt.

    lt_objects = get_git_objects( io_repo ).

    mt_commits = parse_commits( lt_objects ).
    _sort_commits( CHANGING ct_commits = mt_commits ).

    parse_annotated_tags( lt_objects ).

    CLEAR lt_objects.

    determine_branch( ).
    determine_merges( ).
    determine_tags( ).
    fixes( ).

  ENDMETHOD.