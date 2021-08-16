  METHOD get_comment_object.

    DATA: lv_count TYPE i,
          lv_value TYPE c LENGTH 10,
          ls_item  TYPE zif_abapgit_definitions=>ty_item,
          lt_items TYPE zif_abapgit_definitions=>ty_items_tt.

    FIELD-SYMBOLS: <ls_stage> LIKE LINE OF it_stage.

    " Get objects
    LOOP AT it_stage ASSIGNING <ls_stage>.
      CLEAR ls_item.
      ls_item-obj_type = <ls_stage>-status-obj_type.
      ls_item-obj_name = <ls_stage>-status-obj_name.
      COLLECT ls_item INTO lt_items.
    ENDLOOP.

    lv_count = lines( lt_items ).

    IF lv_count = 1.
      " Just one object so we use the object name
      READ TABLE lt_items INTO ls_item INDEX 1.
      ASSERT sy-subrc = 0.

      CONCATENATE ls_item-obj_type ls_item-obj_name INTO rv_text SEPARATED BY space.
    ELSE.
      " For multiple objects we use the count instead
      WRITE lv_count TO lv_value LEFT-JUSTIFIED.
      CONCATENATE lv_value 'objects' INTO rv_text SEPARATED BY space.
    ENDIF.

  ENDMETHOD.