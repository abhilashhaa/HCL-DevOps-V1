  METHOD split_value_to_keys.

    DATA: lt_key_component_uncovered LIKE it_key_component,
          ls_dummy                   LIKE LINE OF ct_objkey,
          ls_key_component_uncovered LIKE LINE OF lt_key_component_uncovered,
          ls_objkey_sub              LIKE cs_objkey,
          lv_objkey_sub_pos          TYPE i.


    lt_key_component_uncovered = it_key_component.

*    we want to fill the atribute values which are not covered by explicit key components yet
    LOOP AT ct_objkey INTO ls_dummy.
      DELETE lt_key_component_uncovered INDEX 1.
    ENDLOOP.

    ls_objkey_sub-num = cs_objkey-num.
    lv_objkey_sub_pos = 0.
    LOOP AT lt_key_component_uncovered INTO ls_key_component_uncovered.
      CLEAR ls_objkey_sub-value.
      ls_objkey_sub-value = cs_objkey-value+lv_objkey_sub_pos(ls_key_component_uncovered-leng).
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