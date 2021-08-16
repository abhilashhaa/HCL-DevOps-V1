  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_named_collection,
        name TYPE string,
        pile TYPE zif_abapgit_html=>tty_table_of,
      END OF ty_named_collection.
    TYPES:
      tty_named_collection TYPE STANDARD TABLE OF ty_named_collection WITH KEY name.

    DATA mt_part_collections TYPE tty_named_collection.

    METHODS get_collection
      IMPORTING
        !iv_collection TYPE string
        !iv_create_if_missing TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rr_collection) TYPE REF TO ty_named_collection .
