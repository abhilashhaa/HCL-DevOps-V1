  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_msg,
        text TYPE string,
        type TYPE symsgty,
      END OF ty_msg .
    TYPES:
      BEGIN OF ty_log, "in order of occurrence
        msg       TYPE ty_msg,
        rc        TYPE balsort,
        item      TYPE zif_abapgit_definitions=>ty_item,
        exception TYPE REF TO cx_root,
      END OF ty_log .

    DATA:
      mt_log TYPE STANDARD TABLE OF ty_log WITH DEFAULT KEY .
    DATA mv_title TYPE string .

    METHODS get_messages_status
      IMPORTING
        !it_msg          TYPE zif_abapgit_log=>tty_msg
      RETURNING
        VALUE(rv_status) TYPE symsgty .