  METHOD get_item_class.

    DATA lt_class TYPE TABLE OF string.

    IF is_item-is_dir = abap_true.
      APPEND 'folder' TO lt_class.
    ELSEIF is_item-changes > 0.
      APPEND 'modified' TO lt_class.
    ELSEIF is_item-obj_name IS INITIAL.
      APPEND 'unsupported' TO lt_class.
    ENDIF.

    IF lines( lt_class ) > 0.
      rv_html = | class="{ concat_lines_of( table = lt_class
                                            sep = ` ` ) }"|.
    ENDIF.

  ENDMETHOD.