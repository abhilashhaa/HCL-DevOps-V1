  METHOD delete_branch.

    DATA: lo_repo   TYPE REF TO zcl_abapgit_repo_online,
          ls_branch TYPE zif_abapgit_definitions=>ty_git_branch,
          lv_msg    TYPE string,
          li_popups TYPE REF TO zif_abapgit_popups.


    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    ls_branch = li_popups->branch_list_popup( iv_url         = lo_repo->get_url( )
                                              iv_hide_branch = lo_repo->get_branch_name( )
                                              iv_hide_head   = abap_true ).
    IF ls_branch IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_git_porcelain=>delete_branch(
      iv_url    = lo_repo->get_url( )
      is_branch = ls_branch ).

    lv_msg = |Branch { ls_branch-display_name } deleted|.
    MESSAGE lv_msg TYPE 'S'.

  ENDMETHOD.