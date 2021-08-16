  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_overview,
        favorite        TYPE string,
        "! True for offline, false for online repo
        type            TYPE string,
        key             TYPE string,
        name            TYPE string,
        url             TYPE string,
        package         TYPE string,
        branch          TYPE string,
        created_by      TYPE string,
        created_at      TYPE string,
        deserialized_by TYPE string,
        deserialized_at TYPE string,
      END OF ty_overview,
      tty_overview TYPE STANDARD TABLE OF ty_overview
                   WITH NON-UNIQUE DEFAULT KEY.
    CONSTANTS:
      BEGIN OF c_action,
        select       TYPE string VALUE 'select',
        apply_filter TYPE string VALUE 'apply_filter',
      END OF c_action .

    DATA: mv_order_descending TYPE abap_bool,
          mv_filter           TYPE string,
          mv_time_zone        TYPE timezone,
          mt_col_spec         TYPE zif_abapgit_definitions=>tty_col_spec,
          mt_overview         TYPE tty_overview.

    METHODS: render_text_input
      IMPORTING iv_name        TYPE string
                iv_label       TYPE string
                iv_value       TYPE string OPTIONAL
                iv_max_length  TYPE string OPTIONAL
      RETURNING VALUE(ri_html) TYPE REF TO zif_abapgit_html,

      apply_filter
        CHANGING
          ct_overview TYPE tty_overview,

      map_repo_list_to_overview
        IMPORTING
          it_repo_list       TYPE zif_abapgit_persistence=>tt_repo
        RETURNING
          VALUE(rt_overview) TYPE tty_overview
        RAISING
          zcx_abapgit_exception,

      render_table_header
        IMPORTING
          ii_html TYPE REF TO zif_abapgit_html,

      render_table
        IMPORTING
          ii_html     TYPE REF TO zif_abapgit_html
          it_overview TYPE tty_overview,

      render_table_body
        IMPORTING
          ii_html     TYPE REF TO zif_abapgit_html
          it_overview TYPE tty_overview,

      render_header_bar
        IMPORTING
          ii_html TYPE REF TO zif_abapgit_html,

      apply_order_by
        CHANGING ct_overview TYPE tty_overview,

      _add_column
        IMPORTING
          iv_tech_name    TYPE string OPTIONAL
          iv_display_name TYPE string OPTIONAL
          iv_css_class    TYPE string OPTIONAL
          iv_add_tz       TYPE abap_bool OPTIONAL
          iv_title        TYPE string OPTIONAL.

    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception.