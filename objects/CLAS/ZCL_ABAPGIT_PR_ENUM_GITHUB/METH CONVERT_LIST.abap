  METHOD convert_list.

    DATA lt_items TYPE string_table.
    DATA lv_i TYPE string.
    FIELD-SYMBOLS <ls_p> LIKE LINE OF rt_pulls.

    lt_items = ii_json->members( '/' ).

    LOOP AT lt_items INTO lv_i.
      APPEND INITIAL LINE TO rt_pulls ASSIGNING <ls_p>.
      <ls_p>-base_url        = ii_json->get( |/{ lv_i }/base/repo/clone_url| ).
      <ls_p>-number          = ii_json->get( |/{ lv_i }/number| ).
      <ls_p>-title           = ii_json->get( |/{ lv_i }/title| ).
      <ls_p>-user            = ii_json->get( |/{ lv_i }/user/login| ).
      <ls_p>-head_url        = ii_json->get( |/{ lv_i }/head/repo/clone_url| ).
      <ls_p>-head_branch     = ii_json->get( |/{ lv_i }/head/ref| ).
      <ls_p>-created_at      = ii_json->get( |/{ lv_i }/created_at| ).
    ENDLOOP.

  ENDMETHOD.