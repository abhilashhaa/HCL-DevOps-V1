  METHOD zif_abapgit_ajson_reader~members.

    DATA lv_normalized_path TYPE string.
    FIELD-SYMBOLS <ls_item> LIKE LINE OF mt_json_tree.

    lv_normalized_path = lcl_utils=>normalize_path( iv_path ).

    LOOP AT mt_json_tree ASSIGNING <ls_item> WHERE path = lv_normalized_path.
      APPEND <ls_item>-name TO rt_members.
    ENDLOOP.

  ENDMETHOD.