  METHOD remote_change.

    DATA: ls_popup TYPE zif_abapgit_popups=>ty_popup,
          ls_loc   TYPE zif_abapgit_persistence=>ty_repo-local_settings,
          lo_repo  TYPE REF TO zcl_abapgit_repo_online.

    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    ls_loc = lo_repo->get_local_settings( ).

    ls_popup = zcl_abapgit_ui_factory=>get_popups( )->repo_popup(
      iv_title          = 'Change repo remote ...'
      iv_url            = lo_repo->get_url( )
      iv_package        = lo_repo->get_package( )
      iv_display_name   = ls_loc-display_name
      iv_freeze_package = abap_true ).
    IF ls_popup-cancel = abap_true.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lo_repo->set_url( ls_popup-url ).
    lo_repo->set_branch_name( ls_popup-branch_name ).

    ls_loc-display_name = ls_popup-display_name.
    lo_repo->set_local_settings( ls_loc ).

    COMMIT WORK.

  ENDMETHOD.