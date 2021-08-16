  METHOD advanced_submenu.
    DATA: li_gui_functions        TYPE REF TO zif_abapgit_gui_functions,
          lv_supports_ie_devtools TYPE abap_bool.

    li_gui_functions = zcl_abapgit_ui_factory=>get_gui_functions( ).
    lv_supports_ie_devtools = li_gui_functions->is_sapgui_for_windows( ).

    CREATE OBJECT ro_menu.

    ro_menu->add(
      iv_txt = 'Database Utility'
      iv_act = zif_abapgit_definitions=>c_action-go_db
    )->add(
      iv_txt = 'Package to Zip'
      iv_act = zif_abapgit_definitions=>c_action-zip_package
    )->add(
      iv_txt = 'Transport to Zip'
      iv_act = zif_abapgit_definitions=>c_action-zip_transport
    )->add(
      iv_txt = 'Object to Files'
      iv_act = zif_abapgit_definitions=>c_action-zip_object
    )->add(
      iv_txt = 'Test Changed by'
      iv_act = zif_abapgit_definitions=>c_action-changed_by
    )->add(
      iv_txt = 'Debug Info'
      iv_act = zif_abapgit_definitions=>c_action-go_debuginfo ).

    IF lv_supports_ie_devtools = abap_true.
      ro_menu->add(
        iv_txt = 'Open IE DevTools'
        iv_act = zif_abapgit_definitions=>c_action-ie_devtools ).
    ENDIF.

    ro_menu->add(
      iv_txt = 'Performance Test'
      iv_act = zif_abapgit_definitions=>c_action-performance_test ).

  ENDMETHOD.