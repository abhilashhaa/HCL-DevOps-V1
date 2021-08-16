  PRIVATE SECTION.
    TYPES:
      BEGIN OF gty_css_var,
        name  TYPE string,
        value TYPE string,
      END OF gty_css_var,
      gty_css_var_tab TYPE SORTED TABLE OF gty_css_var WITH UNIQUE KEY name.

    METHODS:
      get_css_vars_in_string
        IMPORTING
          iv_string           TYPE string
        RETURNING
          VALUE(rt_variables) TYPE gty_css_var_tab,
      resolve_var_recursively
        IMPORTING
          iv_variable_name TYPE string
        CHANGING
          ct_variables     TYPE gty_css_var_tab
        RAISING
          zcx_abapgit_exception.
    DATA:
      mi_asset_manager TYPE REF TO zif_abapgit_gui_asset_manager,
      mt_files         TYPE string_table.