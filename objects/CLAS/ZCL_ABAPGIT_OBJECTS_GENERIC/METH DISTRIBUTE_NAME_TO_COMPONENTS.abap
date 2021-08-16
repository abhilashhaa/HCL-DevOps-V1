  METHOD distribute_name_to_components.

    DATA: lt_key_component_uncovered  LIKE it_key_component,
          ls_key_component_uncovered  LIKE LINE OF lt_key_component_uncovered,
          ls_objkey_sub               LIKE cs_objkey,
          lv_objkey_sub_pos           TYPE i,
          lv_remaining_length         TYPE i,
          lv_count_components_covered LIKE ls_objkey_sub-num.

    DATA lv_len LIKE ls_key_component_uncovered-leng.


    lt_key_component_uncovered = it_key_component.
    ls_objkey_sub-num = cs_objkey-num.
    lv_objkey_sub_pos = 0.

*    we want to fill the atribute values which are not covered by explicit key components yet
    lv_count_components_covered = ls_objkey_sub-num - 1.
    DO lv_count_components_covered TIMES.
      DELETE lt_key_component_uncovered INDEX 1.
    ENDDO.

    LOOP AT lt_key_component_uncovered INTO ls_key_component_uncovered.
      CLEAR ls_objkey_sub-value.

*      Some datatype used in the key might exceed the total remaining characters length (e. g. SICF)
      TRY.
          lv_remaining_length = strlen( |{ substring( val = cs_objkey-value
                                                      off = lv_objkey_sub_pos ) }| ).
        CATCH cx_sy_range_out_of_bounds.
          lv_remaining_length = 0.
          RETURN. ">>>>>>>>>>>>>>>>>>>>>>>>>>>
      ENDTRY.
      IF ls_key_component_uncovered-leng <= lv_remaining_length.
        lv_len = ls_key_component_uncovered-leng.
      ELSE.
        lv_len = lv_remaining_length.
      ENDIF.

      ls_objkey_sub-value = |{ substring( val = cs_objkey-value
                                          off = lv_objkey_sub_pos
                                          len = lv_len ) }|.
      ls_objkey_sub-num = cv_non_value_pos.

      INSERT ls_objkey_sub INTO TABLE ct_objkey.

      lv_objkey_sub_pos = lv_objkey_sub_pos + ls_key_component_uncovered-leng.
      cv_non_value_pos = cv_non_value_pos + 1.
      CLEAR ls_objkey_sub.

      IF lv_objkey_sub_pos = strlen( cs_objkey-value ).
        cs_objkey-num = cv_non_value_pos.
        EXIT. "end splitting - all characters captured
      ENDIF.
    ENDLOOP.

  ENDMETHOD.