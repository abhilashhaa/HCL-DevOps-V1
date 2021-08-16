  METHOD class_constructor.

    DATA lt_plugin_class    TYPE STANDARD TABLE OF seoclsname WITH DEFAULT KEY.
    DATA lv_plugin_class    LIKE LINE OF lt_plugin_class.
    DATA lo_plugin          TYPE REF TO object.
    DATA lt_plugin_obj_type TYPE objtyptable.
    DATA ls_objtype_map     LIKE LINE OF gt_objtype_map.


    SELECT clsname
      FROM seometarel
      INTO TABLE lt_plugin_class
      WHERE refclsname LIKE 'ZCL_ABAPGITP_OBJECT%'
      AND version = '1'.                                  "#EC CI_SUBRC

    CLEAR gt_objtype_map.
    LOOP AT lt_plugin_class INTO lv_plugin_class
        WHERE table_line <> 'ZCL_ABAPGITP_OBJECT_BY_SOBJ'.
* have the generic plugin only as fallback
      TRY.
          CREATE OBJECT lo_plugin TYPE (lv_plugin_class).
        CATCH cx_sy_create_object_error.
          CONTINUE. ">>>>>>>>>>>>>>
      ENDTRY.

      CALL METHOD lo_plugin->('GET_SUPPORTED_OBJ_TYPES')
        IMPORTING
          rt_obj_type = lt_plugin_obj_type.

      ls_objtype_map-plugin_class = lv_plugin_class.
      LOOP AT lt_plugin_obj_type INTO ls_objtype_map-obj_typ.
        INSERT ls_objtype_map INTO TABLE gt_objtype_map.
        IF sy-subrc <> 0.
* No exception in class-contructor possible.
* Anyway, a shortdump is more appropriate in this case
          ASSERT 'There must not be' =
            |multiple abapGit-Plugins for the same object type {
            ls_objtype_map-obj_typ }|.
        ENDIF.
      ENDLOOP.
    ENDLOOP. "at plugins

* and the same for the generic plugin if exists
* have the generic plugin only as fallback
    LOOP AT lt_plugin_class INTO lv_plugin_class
        WHERE table_line = 'ZCL_ABAPGITP_OBJECT_BY_SOBJ'.
      CREATE OBJECT lo_plugin TYPE (lv_plugin_class).

      CALL METHOD lo_plugin->('GET_SUPPORTED_OBJ_TYPES')
        RECEIVING
          rt_obj_type = lt_plugin_obj_type.

      ls_objtype_map-plugin_class = lv_plugin_class.
      LOOP AT lt_plugin_obj_type INTO ls_objtype_map-obj_typ.
        INSERT ls_objtype_map INTO TABLE gt_objtype_map. "knowingly ignore the subrc
      ENDLOOP.
    ENDLOOP. "at plugins

  ENDMETHOD.