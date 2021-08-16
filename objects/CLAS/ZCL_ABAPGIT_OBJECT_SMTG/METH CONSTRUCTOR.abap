  METHOD constructor.

    super->constructor(
      is_item     = is_item
      iv_language = iv_language ).

    mv_template_id = ms_item-obj_name.
    mo_structdescr = get_structure( ).

  ENDMETHOD.