CLASS zcl_abapgit_message_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF gc_section_text,
        cause           TYPE string VALUE `Cause`,
        system_response TYPE string VALUE `System response`,
        what_to_do      TYPE string VALUE `Procedure`,
        sys_admin       TYPE string VALUE `System administration`,
      END OF gc_section_text .
    CONSTANTS:
      BEGIN OF gc_section_token,
        cause           TYPE string VALUE `&CAUSE&`,
        system_response TYPE string VALUE `&SYSTEM_RESPONSE&`,
        what_to_do      TYPE string VALUE `&WHAT_TO_DO&`,
        sys_admin       TYPE string VALUE `&SYS_ADMIN&`,
      END OF gc_section_token .

    CLASS-METHODS set_msg_vars_for_clike
      IMPORTING
        !iv_text TYPE string .
    METHODS constructor
      IMPORTING
        !io_exception TYPE REF TO zcx_abapgit_exception .
    METHODS get_t100_longtext
      RETURNING
        VALUE(rv_longtext) TYPE string .