  METHOD new_offline.

    DATA: ls_popup        TYPE zif_abapgit_popups=>ty_popup,
          lo_repo         TYPE REF TO zcl_abapgit_repo,
          lo_repo_offline TYPE REF TO zcl_abapgit_repo_offline,
          li_repo_srv     TYPE REF TO zif_abapgit_repo_srv,
          lv_reason       TYPE string.

    ls_popup  = zcl_abapgit_ui_factory=>get_popups( )->repo_new_offline( ).
    IF ls_popup-cancel = abap_true.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    " make sure package is not already in use for a different repository
    " 702: chaining calls with exp&imp parameters causes syntax error
    li_repo_srv = zcl_abapgit_repo_srv=>get_instance( ).
    li_repo_srv->get_repo_from_package(
      EXPORTING
        iv_package = ls_popup-package
      IMPORTING
        eo_repo    = lo_repo
        ev_reason  = lv_reason ).

    IF lo_repo IS BOUND.
      MESSAGE lv_reason TYPE 'S'.
    ELSE.
      " create new repo and add to favorites
      lo_repo_offline = zcl_abapgit_repo_srv=>get_instance( )->new_offline(
        iv_url          = ls_popup-url
        iv_package      = ls_popup-package
        iv_folder_logic = ls_popup-folder_logic
        iv_master_lang_only = ls_popup-master_lang_only ).

      lo_repo_offline->rebuild_local_checksums( ).

      lo_repo ?= lo_repo_offline.

      toggle_favorite( lo_repo->get_key( ) ).
    ENDIF.

    " Set default repo for user
    zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( lo_repo->get_key( ) ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.