  METHOD build_main_menu.

    CREATE OBJECT ro_menu EXPORTING iv_id = 'toolbar-main'.

    ro_menu->add(
      iv_txt = zcl_abapgit_gui_buttons=>new_online( )
      iv_act = zif_abapgit_definitions=>c_action-repo_newonline
    )->add(
      iv_txt = zcl_abapgit_gui_buttons=>new_offline( )
      iv_act = zif_abapgit_definitions=>c_action-repo_newoffline
    )->add(
      iv_txt = zcl_abapgit_gui_buttons=>settings( )
      iv_act = zif_abapgit_definitions=>c_action-go_settings
    )->add(
      iv_txt = zcl_abapgit_gui_buttons=>advanced( )
      io_sub = zcl_abapgit_gui_chunk_lib=>advanced_submenu( )
    )->add(
      iv_txt = zcl_abapgit_gui_buttons=>help( )
      io_sub = zcl_abapgit_gui_chunk_lib=>help_submenu( ) ).

  ENDMETHOD.