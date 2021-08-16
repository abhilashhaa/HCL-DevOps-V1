CLASS zcl_abapgit_settings DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS: c_commitmsg_comment_length_dft TYPE i VALUE 50.
    CONSTANTS: c_commitmsg_body_size_dft      TYPE i VALUE 72.

    CONSTANTS:
      BEGIN OF c_icon_scaling,
        large TYPE c VALUE 'L',
        small TYPE c VALUE 'S',
      END OF c_icon_scaling.

    CONSTANTS:
      BEGIN OF c_ui_theme,
        default         TYPE string VALUE 'default',
        dark            TYPE string VALUE 'dark',
        belize          TYPE string VALUE 'belize',
        synced_with_gui TYPE string VALUE 'synced_with_gui',
      END OF c_ui_theme.

    METHODS:
      set_proxy_url
        IMPORTING
          iv_url TYPE string,
      set_proxy_port
        IMPORTING
          iv_port TYPE string,
      set_proxy_authentication
        IMPORTING
          iv_auth TYPE abap_bool,
      set_proxy_bypass
        IMPORTING
          it_bypass TYPE zif_abapgit_definitions=>ty_range_proxy_bypass_url OPTIONAL,
      get_proxy_url
        RETURNING
          VALUE(rv_proxy_url) TYPE string,
      get_proxy_port
        RETURNING
          VALUE(rv_port) TYPE string,
      get_proxy_authentication
        RETURNING
          VALUE(rv_auth) TYPE abap_bool,
      get_proxy_bypass
        RETURNING VALUE(rt_bypass) TYPE zif_abapgit_definitions=>ty_range_proxy_bypass_url,
      set_run_critical_tests
        IMPORTING
          iv_run TYPE abap_bool,
      get_run_critical_tests
        RETURNING
          VALUE(rv_run) TYPE abap_bool,
      set_experimental_features
        IMPORTING
          iv_run TYPE abap_bool,
      get_experimental_features
        RETURNING
          VALUE(rv_run) TYPE abap_bool,
      set_max_lines
        IMPORTING iv_lines TYPE i,
      get_max_lines
        RETURNING
          VALUE(rv_lines) TYPE i,
      set_adt_jump_enanbled
        IMPORTING
          iv_adt_jump_enabled TYPE abap_bool,
      get_adt_jump_enabled
        RETURNING
          VALUE(rv_adt_jump_enabled) TYPE abap_bool,
      set_commitmsg_comment_length
        IMPORTING
          iv_length TYPE i,
      get_commitmsg_comment_length
        RETURNING
          VALUE(rv_length) TYPE i,
      set_commitmsg_comment_default
        IMPORTING
          iv_default TYPE string,
      get_commitmsg_comment_default
        RETURNING
          VALUE(rv_default) TYPE string,
      set_commitmsg_body_size
        IMPORTING
          iv_length TYPE i,
      get_commitmsg_body_size
        RETURNING
          VALUE(rv_length) TYPE i,
      get_settings_xml
        RETURNING
          VALUE(rv_settings_xml) TYPE string
        RAISING
          zcx_abapgit_exception,
      get_user_settings
        RETURNING
          VALUE(rs_settings) TYPE zif_abapgit_definitions=>ty_s_user_settings
        RAISING
          zcx_abapgit_exception,
      set_xml_settings
        IMPORTING
          iv_settings_xml TYPE string
        RAISING
          zcx_abapgit_exception,
      set_defaults,
      set_user_settings
        IMPORTING
          is_user_settings TYPE zif_abapgit_definitions=>ty_s_user_settings,
      get_show_default_repo
        RETURNING
          VALUE(rv_show_default_repo) TYPE abap_bool,
      set_show_default_repo
        IMPORTING
          iv_show_default_repo TYPE abap_bool,
      set_link_hints_enabled
        IMPORTING
          iv_link_hints_enabled TYPE abap_bool,
      get_link_hints_enabled
        RETURNING
          VALUE(rv_link_hints_enabled) TYPE abap_bool
        RAISING
          zcx_abapgit_exception,
      set_link_hint_key
        IMPORTING
          iv_link_hint_key TYPE string,
      get_link_hint_key
        RETURNING
          VALUE(rv_link_hint_key) TYPE string,
      set_hotkeys
        IMPORTING
          it_hotkeys TYPE zif_abapgit_definitions=>tty_hotkey,
      get_hotkeys
        RETURNING
          VALUE(rt_hotkeys) TYPE zif_abapgit_definitions=>tty_hotkey
        RAISING
          zcx_abapgit_exception,
      set_parallel_proc_disabled
        IMPORTING
          iv_disable_parallel_proc TYPE abap_bool,
      get_parallel_proc_disabled
        RETURNING
          VALUE(rv_disable_parallel_proc) TYPE abap_bool,
      get_icon_scaling
        RETURNING
          VALUE(rv_scaling) TYPE zif_abapgit_definitions=>ty_s_user_settings-icon_scaling,
      set_icon_scaling
        IMPORTING
          iv_scaling TYPE zif_abapgit_definitions=>ty_s_user_settings-icon_scaling,
      get_ui_theme
        IMPORTING
          iv_resolve_synced  TYPE abap_bool DEFAULT abap_true
        RETURNING
          VALUE(rv_ui_theme) TYPE zif_abapgit_definitions=>ty_s_user_settings-ui_theme,
      set_ui_theme
        IMPORTING
          iv_ui_theme TYPE zif_abapgit_definitions=>ty_s_user_settings-ui_theme,
      get_activate_wo_popup
        RETURNING
          VALUE(rv_act_wo_popup) TYPE zif_abapgit_definitions=>ty_s_user_settings-activate_wo_popup,
      set_activate_wo_popup
        IMPORTING
          iv_act_wo_popup TYPE zif_abapgit_definitions=>ty_s_user_settings-activate_wo_popup.