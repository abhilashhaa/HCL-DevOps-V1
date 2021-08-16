CLASS zcl_abapgit_hotkeys DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_abapgit_gui_component
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      zif_abapgit_gui_hotkey_ctl,
      zif_abapgit_gui_hotkeys,
      zif_abapgit_gui_renderable.

    CONSTANTS:
      c_showhotkeys_action TYPE string VALUE `showHotkeys` ##NO_TEXT.

    CLASS-METHODS:
      get_all_default_hotkeys
        RETURNING
          VALUE(rt_hotkey_actions) TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr
        RAISING
          zcx_abapgit_exception,

      merge_hotkeys_with_settings
        CHANGING
          ct_hotkey_actions TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr
        RAISING
          zcx_abapgit_exception.

    CLASS-METHODS:
      should_show_hint
        RETURNING
          VALUE(rv_yes) TYPE abap_bool.
