  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_subitem,
        label TYPE string,
        value TYPE string,
      END OF ty_subitem .
    TYPES:
      tty_subitems TYPE STANDARD TABLE OF ty_subitem WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_field,
        type          TYPE i,
        name          TYPE string,
        label         TYPE string,
        hint          TYPE string,
        dblclick      TYPE string,
        placeholder   TYPE string,
        required      TYPE string,
        upper_case    TYPE abap_bool,
        item_class    TYPE string,
        error         TYPE string,
        default_value TYPE string,
        side_action   TYPE string,
        subitems      TYPE tty_subitems,
*        onclick ???
      END OF ty_field .
    TYPES:
      BEGIN OF ty_command,
        label   TYPE string,
        action  TYPE string,
        is_main TYPE abap_bool,
        as_a    TYPE abap_bool,
*        onclick ???
      END OF ty_command .

    CONSTANTS:
      BEGIN OF c_field_type,
        text        TYPE i VALUE 1,
        radio       TYPE i VALUE 2,
        checkbox    TYPE i VALUE 3,
        field_group TYPE i VALUE 4,
      END OF c_field_type .
    DATA:
      mt_fields TYPE STANDARD TABLE OF ty_field
        WITH UNIQUE SORTED KEY by_name COMPONENTS name.
    DATA:
      mt_commands TYPE STANDARD TABLE OF ty_command.
    DATA mv_form_id TYPE string .

    METHODS render_field
      IMPORTING
        !ii_html           TYPE REF TO zif_abapgit_html
        !io_values         TYPE REF TO zcl_abapgit_string_map
        !io_validation_log TYPE REF TO zcl_abapgit_string_map
        !is_field          TYPE ty_field .
    METHODS render_command
      IMPORTING
        !ii_html TYPE REF TO zif_abapgit_html
        !is_cmd  TYPE ty_command .