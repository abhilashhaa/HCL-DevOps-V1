  METHOD zif_abapgit_object~deserialize.

    DATA: ls_char        TYPE ty_char,
          ls_description LIKE LINE OF ls_char-cls_attributet,
          lo_char        TYPE REF TO cl_cls_attribute,
          lx_pak_error   TYPE REF TO cx_root,
          lv_text        TYPE string.

    FIELD-SYMBOLS: <ls_value>  LIKE LINE OF ls_char-cls_attr_value,
                   <lg_any>    TYPE any,
                   <ls_valuet> LIKE LINE OF ls_char-cls_attr_valuet.


    io_xml->read( EXPORTING iv_name = 'CHAR'
                  CHANGING cg_data = ls_char ).

    tadir_insert( iv_package ).

    lo_char = instantiate_char_and_lock( iv_type_group       = ls_char-cls_attribute-type_group
                                         iv_activation_state = cl_pak_wb_domains=>co_activation_state-inactive ).

    TRY.
        lo_char->if_cls_attribute~set_kind( ls_char-cls_attribute-kind ).
        lo_char->if_cls_attribute~set_single_valued( ls_char-cls_attribute-is_single_valued ).
        lo_char->if_cls_attribute~set_aspect(
          im_aspect_for   = ls_char-cls_attribute-is_aspect_for
          im_aspect_value = ls_char-cls_attribute-aspect_value ).
        lo_char->if_cls_attribute~set_default_flag( ls_char-cls_attribute-default_flag ).
        lo_char->if_cls_attribute~set_default_value( ls_char-cls_attribute-default_value ).
        lo_char->if_cls_attribute~set_sub_object_treatment( ls_char-cls_attribute-sub_obj_treatm ).
        lo_char->if_cls_attribute~set_automatic_changes_allowed( ls_char-cls_attribute-automatic_change ).
        lo_char->if_cls_attribute~set_manual_changes_allowed( ls_char-cls_attribute-manu_chag_allow ).
        lo_char->if_cls_attribute~set_implicit_changes_allowed( ls_char-cls_attribute-implicit_change ).
        lo_char->if_cls_attribute~set_expl_values_dominate_links( ls_char-cls_attribute-weak_links ).
        lo_char->if_cls_attribute~set_assignment_package_rule( ls_char-cls_attribute-assignment_devc ).

* Method SET_HIDE_ICON does not exist in some releases, not present in 751
        ASSIGN COMPONENT 'HIDE_ICONS' OF STRUCTURE ls_char-cls_attribute TO <lg_any>.
        IF sy-subrc = 0.
          CALL METHOD lo_char->('IF_CLS_ATTRIBUTE~SET_HIDE_ICON')
            EXPORTING
              im_hide_icon = <lg_any>.
        ENDIF.

        lo_char->if_cls_attribute~set_hide_remark( ls_char-cls_attribute-hide_remark ).
        lo_char->if_cls_attribute~set_visible_in_customer_system( ls_char-cls_attribute-visible_for_cust ).
        lo_char->if_cls_attribute~set_value_table( ls_char-cls_attribute-value_table ).
        lo_char->if_cls_attribute~set_vtable_field( ls_char-cls_attribute-vtable_field ).
        lo_char->if_cls_attribute~set_vtable_icon_f( ls_char-cls_attribute-vtable_icon_f ).
        lo_char->if_cls_attribute~set_vtext_langu_f( ls_char-cls_attribute-vtext_langu_f ).
        lo_char->if_cls_attribute~set_vtext_table( ls_char-cls_attribute-vtext_table ).
        lo_char->if_cls_attribute~set_vtext_text_f( ls_char-cls_attribute-vtext_text_f ).
        lo_char->if_cls_attribute~set_vtext_value_f( ls_char-cls_attribute-vtext_value_f ).
        lo_char->if_cls_attribute~set_existing_objects_only( ls_char-cls_attribute-existing_objects ).
        lo_char->if_cls_attribute~set_objs_of_typegr( ls_char-cls_attribute-objs_of_typegr ).
        lo_char->if_cls_attribute~set_obj_values_have_subtypes( ls_char-cls_attribute-objs_w_subtype ).
        lo_char->if_cls_attribute~set_arbtry_val_type( ls_char-cls_attribute-arbtry_val_type ).

        READ TABLE ls_char-cls_attributet INTO ls_description WITH KEY langu = mv_language.
        IF sy-subrc <> 0.
          READ TABLE ls_char-cls_attributet INTO ls_description INDEX 1.
        ENDIF.
        lo_char->if_cls_attribute~set_description( ls_description-text ).

        LOOP AT ls_char-cls_attr_value ASSIGNING <ls_value>.
          <ls_value>-activation_state = 'I'.
        ENDLOOP.
        LOOP AT ls_char-cls_attr_valuet ASSIGNING <ls_valuet>.
          <ls_valuet>-activation_state = 'I'.
        ENDLOOP.

        lo_char->if_cls_attribute~set_values(
          im_values   = ls_char-cls_attr_value
          im_values_t = ls_char-cls_attr_valuet ).

        set_default_package( iv_package ).

        lo_char->if_pak_wb_object~save( ).

        lo_char->if_pak_wb_object~activate( ).

        lo_char->if_pak_wb_object_internal~unlock( ).

      CATCH cx_pak_invalid_state cx_pak_invalid_data cx_pak_not_authorized INTO lx_pak_error.
        lo_char->if_pak_wb_object_internal~unlock( ).
        lv_text = lx_pak_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
      CLEANUP.
        lo_char->if_pak_wb_object_internal~unlock( ).
    ENDTRY.

  ENDMETHOD.