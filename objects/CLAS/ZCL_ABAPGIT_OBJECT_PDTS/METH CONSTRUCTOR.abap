  METHOD constructor.

    super->constructor( is_item     = is_item
                        iv_language = iv_language ).

    IF is_experimental( ) = abap_false.
      "Alpha version, known issues:
      "- Container texts not de/serialized properly (functionally OK)
      "- Container handling still a bad hack, needs refactoring with lots of debugging time
      "- Probably has a few more bugs, more testing needed
      zcx_abapgit_exception=>raise( 'PDTS not fully implemented, enable experimental features to test it' ).
    ENDIF.

    ms_objkey-otype = c_object_type_task.
    ms_objkey-objid = ms_item-obj_name.

    mv_objid = ms_item-obj_name.  "Todo: Obsolete

  ENDMETHOD.