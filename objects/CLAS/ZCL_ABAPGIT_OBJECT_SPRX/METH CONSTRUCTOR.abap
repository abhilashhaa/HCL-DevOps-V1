  METHOD constructor.

    super->constructor( is_item     = is_item
                        iv_language = iv_language ).

    get_object_and_name(
      IMPORTING
        ev_object   = mv_object
        ev_obj_name = mv_obj_name ).

  ENDMETHOD.