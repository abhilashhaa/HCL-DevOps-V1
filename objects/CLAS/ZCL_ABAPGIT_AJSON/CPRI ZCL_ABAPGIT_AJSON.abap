  PRIVATE SECTION.

    DATA mt_json_tree TYPE ty_nodes_ts.
    DATA mv_read_only TYPE abap_bool.

    METHODS get_item
      IMPORTING
        iv_path        TYPE string
      RETURNING
        VALUE(rv_item) TYPE REF TO ty_node.
