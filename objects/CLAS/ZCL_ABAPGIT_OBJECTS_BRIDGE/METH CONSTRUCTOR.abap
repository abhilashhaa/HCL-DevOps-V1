  METHOD constructor.

    DATA ls_objtype_map LIKE LINE OF gt_objtype_map.

    super->constructor( is_item = is_item
                        iv_language = zif_abapgit_definitions=>c_english ).

*    determine the responsible plugin
    READ TABLE gt_objtype_map INTO ls_objtype_map
      WITH TABLE KEY obj_typ = is_item-obj_type.
    IF sy-subrc = 0.
      CREATE OBJECT mo_plugin TYPE (ls_objtype_map-plugin_class).

      CALL METHOD mo_plugin->('SET_ITEM')
        EXPORTING
          iv_obj_type = is_item-obj_type
          iv_obj_name = is_item-obj_name.
    ELSE.
      RAISE EXCEPTION TYPE cx_sy_create_object_error
        EXPORTING
          classname = 'LCL_OBJECTS_BRIDGE'.
    ENDIF.
  ENDMETHOD.