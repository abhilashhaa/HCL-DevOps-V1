  METHOD add_menu_begin.

    io_menu->add(
        iv_txt   = |Refresh Local|
        iv_typ   = zif_abapgit_html=>c_action_type-dummy
        iv_act   = c_actions-refresh_local
        iv_id    = c_actions-refresh_local
        iv_title = |Refresh all local objects, without refreshing the remote| ).

    io_menu->add(
        iv_txt   = |Refresh|
        iv_typ   = zif_abapgit_html=>c_action_type-dummy
        iv_act   = c_actions-refresh
        iv_id    = c_actions-refresh
        iv_title = |Complete refresh of all objects, local and remote| ).

  ENDMETHOD.