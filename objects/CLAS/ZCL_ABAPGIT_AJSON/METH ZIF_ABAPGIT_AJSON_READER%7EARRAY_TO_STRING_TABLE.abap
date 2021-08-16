  METHOD zif_abapgit_ajson_reader~array_to_string_table.

    DATA lv_normalized_path TYPE string.
    DATA lr_node TYPE REF TO ty_node.
    DATA lv_tmp TYPE string.
    FIELD-SYMBOLS <ls_item> LIKE LINE OF mt_json_tree.

    lv_normalized_path = lcl_utils=>normalize_path( iv_path ).
    lr_node = get_item( iv_path ).

    IF lr_node IS INITIAL.
      zcx_abapgit_ajson_error=>raise_json( |Path not found: { iv_path }| ).
    ENDIF.
    IF lr_node->type <> 'array'.
      zcx_abapgit_ajson_error=>raise_json( |Array expected at: { iv_path }| ).
    ENDIF.

    LOOP AT mt_json_tree ASSIGNING <ls_item> WHERE path = lv_normalized_path.
      CASE <ls_item>-type.
        WHEN 'num' OR 'str'.
          APPEND <ls_item>-value TO rt_string_table.
        WHEN 'null'.
          APPEND '' TO rt_string_table.
        WHEN 'bool'.
          IF <ls_item>-value = 'true'.
            lv_tmp = abap_true.
          ELSE.
            CLEAR lv_tmp.
          ENDIF.
          APPEND lv_tmp TO rt_string_table.
        WHEN OTHERS.
          zcx_abapgit_ajson_error=>raise_json(
            |Cannot convert [{ <ls_item>-type }] to string at [{ <ls_item>-path }{ <ls_item>-name }]| ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.