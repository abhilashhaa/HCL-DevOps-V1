CLASS zcl_abapgit_gui_page_settings DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abapgit_gui_page.

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF c_action,
        save_settings       TYPE string VALUE 'save_settings',
        change_proxy_bypass TYPE string VALUE 'change_proxy_bypass',
      END OF c_action.

    METHODS constructor
      RAISING zcx_abapgit_exception.
    METHODS zif_abapgit_gui_event_handler~on_event REDEFINITION.
