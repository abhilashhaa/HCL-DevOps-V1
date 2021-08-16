CLASS zcl_abapgit_gui_page_view_repo DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_abapgit_gui_page
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF c_actions,
        repo_list                TYPE string VALUE 'abapgit_home' ##NO_TEXT,
        change_dir               TYPE string VALUE 'change_dir' ##NO_TEXT,
        toggle_hide_files        TYPE string VALUE 'toggle_hide_files' ##NO_TEXT,
        toggle_folders           TYPE string VALUE 'toggle_folders' ##NO_TEXT,
        toggle_changes           TYPE string VALUE 'toggle_changes' ##NO_TEXT,
        toggle_diff_first        TYPE string VALUE 'toggle_diff_first ' ##NO_TEXT,
        display_more             TYPE string VALUE 'display_more' ##NO_TEXT,
        repo_switch_origin_to_pr TYPE string VALUE 'repo_switch_origin_to_pr',
        repo_reset_origin        TYPE string VALUE 'repo_reset_origin',
      END OF c_actions.


    INTERFACES: zif_abapgit_gui_hotkeys.

    METHODS constructor
      IMPORTING
        !iv_key TYPE zif_abapgit_persistence=>ty_repo-key
      RAISING
        zcx_abapgit_exception .

    METHODS zif_abapgit_gui_event_handler~on_event REDEFINITION.
