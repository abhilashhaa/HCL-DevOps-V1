  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_tag_out.
        INCLUDE TYPE zif_abapgit_definitions=>ty_git_tag.
    TYPES: body_icon TYPE icon_d,
           END OF ty_tag_out,
           tty_tag_out TYPE STANDARD TABLE OF ty_tag_out
                       WITH NON-UNIQUE DEFAULT KEY.

    DATA:
      mt_tags              TYPE tty_tag_out,
      mo_docking_container TYPE REF TO cl_gui_docking_container,
      mo_text_control      TYPE REF TO cl_gui_textedit.

    METHODS:
      on_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING row column,

      prepare_tags_for_display
        IMPORTING
          it_tags            TYPE zif_abapgit_definitions=>ty_git_tag_list_tt
        RETURNING
          VALUE(rt_tags_out) TYPE tty_tag_out,

      clean_up,

      show_docking_container_with
        IMPORTING
          iv_text TYPE string.
