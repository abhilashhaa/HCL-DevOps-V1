*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

*INTERFACE lif_ddic_checks.
*  METHODS check_table_or_view_name_tab
*    IMPORTING
*      iv_val               TYPE csequence
*      it_packages          TYPE string_hashed_table
*      iv_incl_sub_packages TYPE abap_bool DEFAULT abap_false
*      iv_bypass_buffer     TYPE abap_bool DEFAULT abap_false
*      iv_dialect           TYPE flag DEFAULT cl_abap_dyn_prg=>dialect_open_sql
*    RETURNING
*      VALUE(rv_val_str)    TYPE string
*    RAISING
*      cx_abap_not_a_table
*      cx_abap_not_in_package .
*  METHODS ddif_nametab_get
*    IMPORTING
*      iv_tabname TYPE ddobjname
*    EXPORTING
*      et_x031l   TYPE dd_x031l_table
*      et_dfies   TYPE ddfields
*      ev_subrc   TYPE syst_subrc.
*  METHODS ddut_texttable_get
*    IMPORTING
*      iv_tabname    TYPE ddobjname
*    EXPORTING
*      ev_texttable  TYPE dd08v-tabname
*      ev_checkfield TYPE dd08v-fieldname.
*  METHODS function_exists
*    IMPORTING
*      iv_funcname               TYPE rs38l_fnam
*    RETURNING
*      VALUE(rv_function_exists) TYPE boole_d.
*ENDINTERFACE.