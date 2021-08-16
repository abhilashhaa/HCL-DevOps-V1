  METHOD constructor.
    super->constructor( is_item = is_item
                        iv_language = iv_language ).
    mv_tree_id = ms_item-obj_name.
  ENDMETHOD.