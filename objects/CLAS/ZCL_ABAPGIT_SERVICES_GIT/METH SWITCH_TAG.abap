  METHOD switch_tag.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo_online,
          ls_tag  TYPE zif_abapgit_definitions=>ty_git_tag.

    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    ls_tag = zcl_abapgit_ui_factory=>get_tag_popups( )->tag_select_popup( lo_repo ).
    IF ls_tag IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    lo_repo->set_branch_name( ls_tag-name ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.