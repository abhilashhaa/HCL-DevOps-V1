  METHOD get_item.

    FIELD-SYMBOLS <ls_item> LIKE LINE OF mt_json_tree.
    DATA ls_path_name TYPE ty_path_name.
    ls_path_name = lcl_utils=>split_path( iv_path ).

    READ TABLE mt_json_tree
      ASSIGNING <ls_item>
      WITH KEY
        path = ls_path_name-path
        name = ls_path_name-name.
    IF sy-subrc = 0.
      GET REFERENCE OF <ls_item> INTO rv_item.
    ENDIF.

  ENDMETHOD.