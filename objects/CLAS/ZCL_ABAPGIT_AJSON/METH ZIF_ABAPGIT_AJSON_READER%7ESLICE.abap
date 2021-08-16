  METHOD zif_abapgit_ajson_reader~slice.

    DATA lo_section         TYPE REF TO zcl_abapgit_ajson.
    DATA ls_item            LIKE LINE OF mt_json_tree.
    DATA lv_normalized_path TYPE string.
    DATA ls_path_parts      TYPE ty_path_name.
    DATA lv_path_len        TYPE i.

    CREATE OBJECT lo_section.
    lv_normalized_path = lcl_utils=>normalize_path( iv_path ).
    lv_path_len        = strlen( lv_normalized_path ).
    ls_path_parts      = lcl_utils=>split_path( lv_normalized_path ).

    LOOP AT mt_json_tree INTO ls_item.
      " TODO potentially improve performance due to sorted tree (all path started from same prefix go in a row)
      IF strlen( ls_item-path ) >= lv_path_len
          AND substring(
            val = ls_item-path
            len = lv_path_len ) = lv_normalized_path.
        ls_item-path = substring(
          val = ls_item-path
          off = lv_path_len - 1 ). " less closing '/'
        INSERT ls_item INTO TABLE lo_section->mt_json_tree.
      ELSEIF ls_item-path = ls_path_parts-path AND ls_item-name = ls_path_parts-name.
        CLEAR: ls_item-path, ls_item-name. " this becomes a new root
        INSERT ls_item INTO TABLE lo_section->mt_json_tree.
      ENDIF.
    ENDLOOP.

    ri_json = lo_section.

  ENDMETHOD.