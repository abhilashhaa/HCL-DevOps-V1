  METHOD constructor.
    super->constructor( is_item     = is_item
                        iv_language = iv_language ).
    IF is_item-devclass IS NOT INITIAL.
      mv_local_devclass = is_item-devclass.
    ELSE.
      mv_local_devclass = is_item-obj_name.
    ENDIF.
  ENDMETHOD.