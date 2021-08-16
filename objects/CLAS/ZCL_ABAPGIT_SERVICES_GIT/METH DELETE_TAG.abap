  METHOD delete_tag.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo_online,
          ls_tag  TYPE zif_abapgit_definitions=>ty_git_tag,
          lv_text TYPE string.

    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    ls_tag = zcl_abapgit_ui_factory=>get_tag_popups( )->tag_select_popup( lo_repo ).
    IF ls_tag IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_git_porcelain=>delete_tag(
      iv_url = lo_repo->get_url( )
      is_tag = ls_tag ).

    lv_text = |Tag { zcl_abapgit_git_tag=>remove_tag_prefix( ls_tag-name ) } deleted|.

    MESSAGE lv_text TYPE 'S'.

  ENDMETHOD.