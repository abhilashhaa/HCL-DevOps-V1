  METHOD do_install.

    DATA: lo_repo   TYPE REF TO zcl_abapgit_repo_online,
          lv_answer TYPE c LENGTH 1.


    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = iv_title
      iv_text_question         = iv_text
      iv_text_button_1         = 'Continue'
      iv_text_button_2         = 'Cancel'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer <> '1'.
      RETURN.
    ENDIF.

    IF abap_false = zcl_abapgit_repo_srv=>get_instance( )->is_repo_installed(
        iv_url              = iv_url
        iv_target_package   = iv_package ).

      zcl_abapgit_factory=>get_sap_package( iv_package )->create_local( ).

      lo_repo = zcl_abapgit_repo_srv=>get_instance( )->new_online(
        iv_url         = iv_url
        iv_branch_name = zif_abapgit_definitions=>c_git_branch-master
        iv_package     = iv_package ).

      zcl_abapgit_services_repo=>gui_deserialize( lo_repo ).

      zcl_abapgit_services_repo=>toggle_favorite( lo_repo->get_key( ) ).
    ENDIF.

    COMMIT WORK.

  ENDMETHOD.