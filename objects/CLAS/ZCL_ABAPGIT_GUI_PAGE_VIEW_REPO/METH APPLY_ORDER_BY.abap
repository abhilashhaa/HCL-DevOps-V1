  METHOD apply_order_by.

    DATA:
      lt_sort                        TYPE abap_sortorder_tab,
      ls_sort                        LIKE LINE OF lt_sort,
      lt_non_code_and_metadata_items LIKE ct_repo_items,
      lt_code_items                  LIKE ct_repo_items,
      lt_diff_items                  LIKE ct_repo_items.

    FIELD-SYMBOLS:
      <ls_repo_item> TYPE zif_abapgit_definitions=>ty_repo_item.

    IF mv_order_by IS INITIAL.
      RETURN.
    ENDIF.

    " we want to preserve non-code and metadata files at the top,
    " so we isolate them and and sort only the code artifacts
    LOOP AT ct_repo_items ASSIGNING <ls_repo_item>.

      IF <ls_repo_item>-obj_type IS INITIAL AND <ls_repo_item>-is_dir = abap_false.
        INSERT <ls_repo_item> INTO TABLE lt_non_code_and_metadata_items.
      ELSE.
        INSERT <ls_repo_item> INTO TABLE lt_code_items.
      ENDIF.

    ENDLOOP.

    IF mv_diff_first = abap_true.
      " fix diffs on the top, right after non-code and metadata
      LOOP AT lt_code_items ASSIGNING <ls_repo_item>
                            WHERE changes > 0.
        INSERT <ls_repo_item> INTO TABLE lt_diff_items.
      ENDLOOP.

      DELETE lt_code_items WHERE changes > 0.
    ENDIF.

    CLEAR: ct_repo_items.

    ls_sort-name       = mv_order_by.
    ls_sort-descending = mv_order_descending.
    ls_sort-astext     = abap_true.
    INSERT ls_sort INTO TABLE lt_sort.
    SORT lt_code_items BY (lt_sort).
    SORT lt_diff_items BY (lt_sort).

    INSERT LINES OF lt_non_code_and_metadata_items INTO TABLE ct_repo_items.
    INSERT LINES OF lt_diff_items INTO TABLE ct_repo_items.
    INSERT LINES OF lt_code_items INTO TABLE ct_repo_items.

  ENDMETHOD.