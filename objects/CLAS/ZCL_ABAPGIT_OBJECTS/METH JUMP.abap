  METHOD jump.

    DATA: li_obj              TYPE REF TO zif_abapgit_object,
          lv_adt_jump_enabled TYPE abap_bool.

    li_obj = create_object( is_item     = is_item
                            iv_language = zif_abapgit_definitions=>c_english ).

    IF li_obj->exists( ) = abap_false.
      zcx_abapgit_exception=>raise( |Object { is_item-obj_type } { is_item-obj_name } doesn't exist| ).
    ENDIF.

    lv_adt_jump_enabled = zcl_abapgit_persist_settings=>get_instance( )->read( )->get_adt_jump_enabled( ).

    IF lv_adt_jump_enabled = abap_true.

      TRY.
          zcl_abapgit_objects_super=>jump_adt(
            iv_obj_name     = is_item-obj_name
            iv_obj_type     = is_item-obj_type
            iv_sub_obj_name = iv_sub_obj_name
            iv_sub_obj_type = iv_sub_obj_type
            iv_line_number  = iv_line_number ).
        CATCH zcx_abapgit_exception.
          li_obj->jump( ).
      ENDTRY.

    ELSEIF iv_line_number IS NOT INITIAL
        AND iv_sub_obj_type IS NOT INITIAL
        AND iv_sub_obj_name IS NOT INITIAL.

      " For the line navigation we have to supply the sub object type (i_sub_obj_type).
      " If we use is_item-obj_type it navigates only to the object.

      CALL FUNCTION 'RS_TOOL_ACCESS'
        EXPORTING
          operation           = 'SHOW'
          object_name         = is_item-obj_name
          object_type         = iv_sub_obj_type
          include             = iv_sub_obj_name
          position            = iv_line_number
          in_new_window       = abap_true
        EXCEPTIONS
          not_executed        = 1
          invalid_object_type = 2
          OTHERS              = 3.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ELSE.
      li_obj->jump( ).
    ENDIF.

  ENDMETHOD.