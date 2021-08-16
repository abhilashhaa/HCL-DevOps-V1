  METHOD remote_attach.

    DATA: ls_popup TYPE zif_abapgit_popups=>ty_popup,
          ls_loc   TYPE zif_abapgit_persistence=>ty_repo-local_settings,
          lo_repo  TYPE REF TO zcl_abapgit_repo_online.

    ls_loc = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key )->get_local_settings( ).

    ls_popup = zcl_abapgit_ui_factory=>get_popups( )->repo_popup(
      iv_title          = 'Attach repo to remote ...'
      iv_url            = ''
      iv_display_name   = ls_loc-display_name
      iv_package        = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key )->get_package( )
      iv_freeze_package = abap_true ).
    IF ls_popup-cancel = abap_true.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_repo_srv=>get_instance( )->get( iv_key )->switch_repo_type( iv_offline = abap_false ).
    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lo_repo->set_url( ls_popup-url ).
    lo_repo->set_branch_name( ls_popup-branch_name ).

    ls_loc = lo_repo->get_local_settings( ). " Just in case ... if switch affects LS state
    ls_loc-display_name = ls_popup-display_name.
    lo_repo->set_local_settings( ls_loc ).

    COMMIT WORK.

  ENDMETHOD.