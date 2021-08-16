  METHOD pull.

    DATA: ls_object LIKE LINE OF rs_result-objects,
          ls_commit TYPE zcl_abapgit_git_pack=>ty_commit.


    zcl_abapgit_git_transport=>upload_pack_by_branch(
      EXPORTING
        iv_url         = iv_url
        iv_branch_name = iv_branch_name
      IMPORTING
        et_objects     = rs_result-objects
        ev_branch      = rs_result-branch ).

    READ TABLE rs_result-objects INTO ls_object
      WITH KEY type COMPONENTS
        type = zif_abapgit_definitions=>c_type-commit
        sha1 = rs_result-branch.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Commit/branch not found' ).
    ENDIF.
    ls_commit = zcl_abapgit_git_pack=>decode_commit( ls_object-data ).

    walk( EXPORTING it_objects = rs_result-objects
                    iv_sha1 = ls_commit-tree
                    iv_path = '/'
          CHANGING ct_files = rs_result-files ).

  ENDMETHOD.