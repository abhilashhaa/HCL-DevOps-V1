  METHOD render_supported_object_types.

    DATA: lv_list     TYPE string,
          lt_types    TYPE zcl_abapgit_objects=>ty_types_tt,
          lv_type     LIKE LINE OF lt_types,
          lt_obj      TYPE STANDARD TABLE OF ko100 WITH DEFAULT KEY,
          lv_class    TYPE seoclsname,
          li_object   TYPE REF TO zif_abapgit_object,
          ls_item     TYPE zif_abapgit_definitions=>ty_item,
          ls_metadata TYPE zif_abapgit_definitions=>ty_metadata,
          lv_step     TYPE zif_abapgit_definitions=>ty_deserialization_step,
          lt_steps    TYPE zif_abapgit_definitions=>ty_deserialization_step_tt.

    FIELD-SYMBOLS: <ls_obj> TYPE ko100.

    CALL FUNCTION 'TR_OBJECT_TABLE'
      TABLES
        wt_object_text = lt_obj.

    lt_types = zcl_abapgit_objects=>supported_list( ).

    rv_html = |<p>Supported objects: { lv_list }</p>|.

    rv_html = rv_html && |<table border="1px"><thead><tr>|.
    rv_html = rv_html && |<td>Object</td><td>Description</td><td>Class</td><td>Version</td><td>DDIC</td>|.
    rv_html = rv_html && |<td>Delete TADIR</td><td>Steps</td>|.
    rv_html = rv_html && |</tr></thead><tbody>|.

    LOOP AT lt_types INTO lv_type.
      lv_class = 'ZCL_ABAPGIT_OBJECT_' && lv_type.

      rv_html = rv_html && |<tr>|.

      rv_html = rv_html && |<td>{ lv_type }</td>|.

      READ TABLE lt_obj ASSIGNING <ls_obj> WITH KEY pgmid = 'R3TR' object = lv_type.
      IF sy-subrc = 0.
        rv_html = rv_html && |<td>{ <ls_obj>-text }</td>|.
      ELSE.
        rv_html = rv_html && |<td class="warning">>No description</td>|.
      ENDIF.


      TRY.
          ls_item-obj_type = lv_type.
          ls_item-obj_name = 'TEST'.

          CREATE OBJECT li_object TYPE (lv_class)
            EXPORTING
              is_item     = ls_item
              iv_language = sy-langu.

          rv_html = rv_html && |<td>{ get_jump_class( lv_class ) }</td>|.

        CATCH cx_sy_create_object_error.
          TRY. " 2nd step, try looking for plugins
              CREATE OBJECT li_object TYPE zcl_abapgit_objects_bridge
                EXPORTING
                  is_item = ls_item.
            CATCH cx_sy_create_object_error.
              rv_html = rv_html && |<td class="error" colspan="5">{ lv_class } - error instantiating class</td>|.
              CONTINUE.
          ENDTRY.

          rv_html = rv_html && |<td>{ get_jump_class( lv_class ) } (Plug-in)</td>|.
      ENDTRY.

      ls_metadata = li_object->get_metadata( ).

      rv_html = rv_html && |<td>{ ls_metadata-version }</td>|.
      rv_html = rv_html && |<td>{ ls_metadata-ddic }</td>|.
      rv_html = rv_html && |<td>{ ls_metadata-delete_tadir }</td>|.

      lt_steps = li_object->get_deserialize_steps( ).

      CLEAR lv_list.
      LOOP AT lt_steps INTO lv_step.
        IF lv_list IS INITIAL.
          lv_list = lv_step.
        ELSE.
          lv_list = lv_list && `, ` && lv_step.
        ENDIF.
      ENDLOOP.

      rv_html = rv_html && |<td>{ lv_list }</td>|.

      rv_html = rv_html && |</tr>|.

    ENDLOOP.

    rv_html = rv_html && |</tbody></table>|.
    rv_html = rv_html && |<br>|.

  ENDMETHOD.