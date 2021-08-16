  METHOD get_where_clause.

    DATA: lv_objkey_pos      TYPE i,
          lv_next_objkey_pos TYPE i,
          lv_value_pos       TYPE i,
          lv_objkey_length   TYPE i,
          lt_objkey          TYPE ty_t_objkey,
          ls_objkey          LIKE LINE OF lt_objkey,
          lv_non_value_pos   TYPE numc3,
          lt_key_fields      TYPE ddfields.

    DATA: lv_is_asterix      TYPE abap_bool,
          lv_where_statement TYPE string,
          lv_key_pos         TYPE i,
          lv_value128        TYPE string.

    FIELD-SYMBOLS <ls_object_table> LIKE LINE OF mt_object_table.

    FIELD-SYMBOLS <ls_table_field> LIKE LINE OF lt_key_fields.


    READ TABLE mt_object_table ASSIGNING <ls_object_table> WITH KEY tobj_name = iv_tobj_name.
    ASSERT sy-subrc = 0.

    lt_key_fields = get_key_fields( iv_tobj_name ).

*   analyze the object key and compose the key (table)
    CLEAR lt_objkey.
    CLEAR ls_objkey.
    lv_objkey_pos = 0.
    lv_non_value_pos = 1.
    lv_value_pos = 0.
    lv_objkey_length = strlen( <ls_object_table>-tobjkey ).

    WHILE lv_objkey_pos <= lv_objkey_length.
      ls_objkey-num = lv_non_value_pos.
*     command
      IF <ls_object_table>-tobjkey+lv_objkey_pos(1) = '/'.
        IF NOT ls_objkey-value IS INITIAL.
*        We reached the end of a key-definition.
*        this key part may address multiple fields.
*        E. g. six characters may address one boolean field and a five-digit version field.
*        Thus, we need to analyze the remaining key components which have not been covered yet.
          split_value_to_keys(
            EXPORTING
              it_key_component = lt_key_fields
            CHANGING
              ct_objkey        = lt_objkey
              cs_objkey        = ls_objkey
              cv_non_value_pos = lv_non_value_pos ).
        ENDIF.
        lv_next_objkey_pos = lv_objkey_pos + 1.
*       '*' means all further key values
        IF <ls_object_table>-tobjkey+lv_next_objkey_pos(1) = '*'.
          ls_objkey-value = '*'.
          INSERT ls_objkey INTO TABLE lt_objkey.
          CLEAR ls_objkey.
          lv_non_value_pos = lv_non_value_pos + 1.
          lv_objkey_pos = lv_objkey_pos + 1.
*       object name
        ELSEIF <ls_object_table>-tobjkey+lv_next_objkey_pos(1) = '&'.
          "TODO
          ls_objkey-value = ms_item-obj_name.
*    The object name might comprise multiple key components (e. g. WDCC)
*    This string needs to be split
          distribute_name_to_components(
            EXPORTING
              it_key_component = lt_key_fields
            CHANGING
              ct_objkey        = lt_objkey
              cs_objkey        = ls_objkey
              cv_non_value_pos = lv_non_value_pos ).
          CLEAR ls_objkey.
          lv_objkey_pos = lv_objkey_pos + 1.
*       language
        ELSEIF <ls_object_table>-tobjkey+lv_next_objkey_pos(1) = 'L'.
          ls_objkey-value = sy-langu.
          INSERT ls_objkey INTO TABLE lt_objkey.
          CLEAR ls_objkey.
          lv_non_value_pos = lv_non_value_pos + 1.
          lv_objkey_pos = lv_objkey_pos + 1.
*       Client
        ELSEIF <ls_object_table>-tobjkey+lv_next_objkey_pos(1) = 'C'.
          ls_objkey-value = sy-mandt.
          INSERT ls_objkey INTO TABLE lt_objkey.
          CLEAR ls_objkey.
          lv_non_value_pos = lv_non_value_pos + 1.
          lv_objkey_pos = lv_objkey_pos + 1.
        ENDIF.
        lv_value_pos = 0.
*     value
      ELSE.
        ls_objkey-value+lv_value_pos(1) = <ls_object_table>-tobjkey+lv_objkey_pos(1).
        lv_value_pos = lv_value_pos + 1.
      ENDIF.

      lv_objkey_pos = lv_objkey_pos + 1.
    ENDWHILE.

*    Similarly to that, fixed values might be supplied in the object key which actually make up key components
    IF NOT ls_objkey-value IS INITIAL.
      split_value_to_keys(
        EXPORTING
          it_key_component = lt_key_fields
        CHANGING
          ct_objkey        = lt_objkey
          cs_objkey        = ls_objkey
          cv_non_value_pos = lv_non_value_pos ).
    ENDIF.

*   compose the where clause
    lv_is_asterix = abap_false.
    lv_key_pos = 1.

    LOOP AT lt_key_fields ASSIGNING <ls_table_field>.
      READ TABLE lt_objkey INTO ls_objkey
        WITH TABLE KEY num = lv_key_pos.
      IF sy-subrc <> 0 OR <ls_table_field>-fieldname = 'LANGU'.
        CLEAR ls_objkey.
        lv_key_pos = lv_key_pos + 1.
        CONTINUE.
      ENDIF.
      IF ls_objkey-value = '*'.
        lv_is_asterix = abap_true.
      ENDIF.
      IF lv_is_asterix = abap_true.
        CONTINUE.
      ENDIF.
      IF NOT lv_where_statement IS INITIAL.
        CONCATENATE lv_where_statement 'AND' INTO lv_where_statement
          SEPARATED BY space.
      ENDIF.
      lv_value128 = cl_abap_dyn_prg=>quote( ls_objkey-value ).
      CONCATENATE lv_where_statement <ls_table_field>-fieldname '='
        lv_value128 INTO lv_where_statement SEPARATED BY space.
      lv_key_pos = lv_key_pos + 1.
    ENDLOOP.

    rv_where = condense( lv_where_statement ).

  ENDMETHOD.