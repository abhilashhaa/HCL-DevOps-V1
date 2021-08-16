  METHOD create_object.

    DATA: lv_message            TYPE string,
          lv_class_name         TYPE string,
          ls_obj_serializer_map LIKE LINE OF gt_obj_serializer_map.


    READ TABLE gt_obj_serializer_map
      INTO ls_obj_serializer_map WITH KEY item = is_item.
    IF sy-subrc = 0.
      lv_class_name = ls_obj_serializer_map-metadata-class.
    ELSEIF is_metadata IS NOT INITIAL.
*        Metadata is provided only on serialization
*        Once this has been triggered, the same serializer shall be used
*        for subsequent processes.
*        Thus, buffer the metadata afterwards
      ls_obj_serializer_map-item      = is_item.
      ls_obj_serializer_map-metadata  = is_metadata.
      INSERT ls_obj_serializer_map INTO TABLE gt_obj_serializer_map.
      lv_class_name = is_metadata-class.
    ELSE.
      lv_class_name = class_name( is_item ).
    ENDIF.

    REPLACE FIRST OCCURRENCE OF 'LCL' IN lv_class_name WITH 'ZCL_ABAPGIT'.

    TRY.
        CREATE OBJECT ri_obj TYPE (lv_class_name)
          EXPORTING
            is_item     = is_item
            iv_language = iv_language.
      CATCH cx_sy_create_object_error.
        lv_message = |Object type { is_item-obj_type } not supported, serialize|.
        IF iv_native_only = abap_false.
          TRY. " 2nd step, try looking for plugins
              CREATE OBJECT ri_obj TYPE zcl_abapgit_objects_bridge
                EXPORTING
                  is_item = is_item.
            CATCH cx_sy_create_object_error.
              zcx_abapgit_exception=>raise( lv_message ).
          ENDTRY.
        ELSE. " No native support? -> fail
          zcx_abapgit_exception=>raise( lv_message ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.