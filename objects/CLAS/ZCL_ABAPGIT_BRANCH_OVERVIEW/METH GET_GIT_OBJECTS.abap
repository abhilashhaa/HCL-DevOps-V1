  METHOD get_git_objects.

    DATA: lo_branch_list       TYPE REF TO zcl_abapgit_git_branch_list,
          li_progress          TYPE REF TO zif_abapgit_progress,
          lt_branches_and_tags TYPE zif_abapgit_definitions=>ty_git_branch_list_tt,
          lt_tags              TYPE zif_abapgit_definitions=>ty_git_branch_list_tt,
          ls_tag               LIKE LINE OF mt_tags.

    FIELD-SYMBOLS: <ls_branch> LIKE LINE OF lt_tags.


    li_progress = zcl_abapgit_progress=>get_instance( 1 ).

    li_progress->show(
      iv_current = 1
      iv_text    = |Get git objects { io_repo->get_name( ) }| ).

* get objects directly from git, mo_repo only contains a shallow clone of only
* the selected branch

    "TODO refactor

    lo_branch_list = zcl_abapgit_git_transport=>branches( io_repo->get_url( ) ).

    mt_branches = lo_branch_list->get_branches_only( ).
    INSERT LINES OF mt_branches INTO TABLE lt_branches_and_tags.

    lt_tags = lo_branch_list->get_tags_only( ).
    INSERT LINES OF lt_tags INTO TABLE lt_branches_and_tags.

    LOOP AT lt_tags ASSIGNING <ls_branch>.

      IF <ls_branch>-name CP '*^{}'.
        CONTINUE.
      ENDIF.

      MOVE-CORRESPONDING <ls_branch> TO ls_tag.
      INSERT ls_tag INTO TABLE mt_tags.
    ENDLOOP.

    zcl_abapgit_git_transport=>upload_pack_by_branch(
      EXPORTING
        iv_url          = io_repo->get_url( )
        iv_branch_name  = io_repo->get_branch_name( )
        iv_deepen_level = 0
        it_branches     = lt_branches_and_tags
      IMPORTING
        et_objects      = rt_objects ).

    DELETE rt_objects WHERE type = zif_abapgit_definitions=>c_type-blob.


  ENDMETHOD.