  METHOD constructor.

    super->constructor( is_item  =  is_item
                        iv_language = iv_language ).

    me->mv_entity_id = is_item-obj_name.

  ENDMETHOD.