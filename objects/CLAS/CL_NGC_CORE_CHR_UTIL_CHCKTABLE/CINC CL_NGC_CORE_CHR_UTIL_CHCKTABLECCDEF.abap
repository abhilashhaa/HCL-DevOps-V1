INTERFACE lif_handle_table_data.
  TYPES:
    lty_db_structure_tab TYPE TABLE OF x031l WITH DEFAULT KEY.

  METHODS:
    check_table_exists
      IMPORTING
                iv_table_name    TYPE tabelle
      RETURNING VALUE(rv_exists) TYPE abap_bool,

    get_table_details
      IMPORTING
        iv_table_name TYPE tabelle
      EXPORTING
        et_field_list TYPE dd_x031l_table
        et_field_info TYPE ddfields
      EXCEPTIONS
        not_found.

ENDINTERFACE.