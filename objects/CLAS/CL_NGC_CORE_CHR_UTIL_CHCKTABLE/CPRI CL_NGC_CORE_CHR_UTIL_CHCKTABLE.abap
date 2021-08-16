private section.

  types:
    BEGIN OF lty_table_data,
        check_table_name TYPE tabelle,
        key_field_name   TYPE fieldname,
        conversion_exit  TYPE convexit,
        length           TYPE ddleng,
      END OF lty_table_data .
  types:
    lty_table_data_table TYPE TABLE OF lty_table_data .

  class-data MT_TABLE_DATA type LTY_TABLE_DATA_TABLE .
  class-data GO_INSTANCE type ref to CL_NGC_CORE_CHR_UTIL_CHCKTABLE .
  class-data MO_TABLE_DATA_HANDLER type ref to LIF_HANDLE_TABLE_DATA .

  methods CONSTRUCTOR .