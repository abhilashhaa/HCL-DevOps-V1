CLASS zcl_abapgit_gui_page_tag DEFINITION PUBLIC FINAL
    CREATE PUBLIC INHERITING FROM zcl_abapgit_gui_page.

  PUBLIC SECTION.

    CONSTANTS: BEGIN OF c_action,
                 commit_post     TYPE string VALUE 'commit_post',
                 commit_cancel   TYPE string VALUE 'commit_cancel',
                 change_tag_type TYPE string VALUE 'change_tag_type',
               END OF c_action.

    METHODS:
      constructor
        IMPORTING io_repo TYPE REF TO zcl_abapgit_repo
        RAISING   zcx_abapgit_exception,

      zif_abapgit_gui_event_handler~on_event REDEFINITION.
