  PROTECTED SECTION.

    TYPES:
      tty_founds  TYPE STANDARD TABLE OF rsfindlst
                           WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      tty_seu_obj TYPE STANDARD TABLE OF seu_obj
                           WITH NON-UNIQUE DEFAULT KEY .

    DATA mi_local TYPE REF TO zif_abapgit_xml_input.

    METHODS get_where_used_recursive
      IMPORTING
        !iv_object_name      TYPE csequence
        !iv_depth            TYPE i
        !iv_object_type      TYPE euobj-id
        !it_scope            TYPE tty_seu_obj
      RETURNING
        VALUE(rt_founds_all) TYPE tty_founds
      RAISING
        zcx_abapgit_exception .
    METHODS is_structure_used_in_db_table
      IMPORTING
        !iv_object_name                       TYPE dd02v-tabname
      RETURNING
        VALUE(rv_is_structure_used_in_db_tab) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS validate
      IMPORTING
        !ii_remote_version TYPE REF TO zif_abapgit_xml_input
        !ii_local_version  TYPE REF TO zif_abapgit_xml_input
        !ii_log            TYPE REF TO zif_abapgit_log
      RETURNING
        VALUE(rv_message)  TYPE string
      RAISING
        zcx_abapgit_exception .