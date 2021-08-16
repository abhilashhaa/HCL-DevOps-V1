  METHOD zif_abapgit_object~deserialize.
    DATA: ls_otgr       TYPE ty_otgr,
          lo_otgr       TYPE REF TO cl_cls_object_type_group,
          lx_pak_error  TYPE REF TO cx_root,
          lv_text       TYPE string,
          lv_masterlang TYPE sy-langu,
          lo_parents    TYPE REF TO data.

    FIELD-SYMBOLS: <ls_groupt>  LIKE LINE OF ls_otgr-texts,
                   <ls_element> LIKE LINE OF ls_otgr-elements,
                   <lv_field>   TYPE any,
                   <ls_parent>  TYPE any,
                   <lt_parents> TYPE ANY TABLE.

    io_xml->read( EXPORTING iv_name = 'OTGR'
                  CHANGING  cg_data = ls_otgr ).

    LOOP AT ls_otgr-texts ASSIGNING <ls_groupt>.
      <ls_groupt>-activation_state = cl_pak_wb_domains=>co_activation_state-inactive.
      " Removed in the method serialize.
      <ls_groupt>-name = ms_item-obj_name.
    ENDLOOP.

    " Parents (cls_tygr_parent) does not exist in lower releases
    TRY.
        CREATE DATA lo_parents TYPE TABLE OF ('CLS_TYGR_PARENT').
        ASSIGN lo_parents->* TO <lt_parents>.
      CATCH cx_sy_create_data_error.
    ENDTRY.

    IF <lt_parents> IS ASSIGNED.
      io_xml->read( EXPORTING iv_name = 'PARENTS'
                    CHANGING  cg_data = <lt_parents>  ).

      LOOP AT <lt_parents> ASSIGNING <ls_parent>.
        ASSIGN COMPONENT 'ACTIVATION_STATE' OF STRUCTURE <ls_parent> TO <lv_field>.
        IF sy-subrc = 0.
          <lv_field> = cl_pak_wb_domains=>co_activation_state-inactive.
        ENDIF.
        ASSIGN COMPONENT 'OBJ_TYPE_GROUP' OF STRUCTURE <ls_parent> TO <lv_field>.
        IF sy-subrc = 0.
          " Removed in the method serialize.
          <lv_field> = ms_item-obj_name.
        ENDIF.
      ENDLOOP.
    ENDIF.

    LOOP AT ls_otgr-elements ASSIGNING <ls_element>.
      <ls_element>-activation_state = cl_pak_wb_domains=>co_activation_state-inactive.
      " Removed in the method serialize.
      <ls_element>-obj_type_group = ms_item-obj_name.
    ENDLOOP.

    tadir_insert( iv_package ).

    lo_otgr = instantiate_and_lock_otgr( ).

    TRY.
        lo_otgr->if_cls_object_type_group~set_proxy_filter( ls_otgr-cls_type_group-proxy_flag ).
        lo_otgr->if_cls_object_type_group~set_elements( ls_otgr-elements ).

        IF <lt_parents> IS ASSIGNED.
          CALL METHOD lo_otgr->('IF_CLS_OBJECT_TYPE_GROUP~SET_PARENT_GROUPS')
            EXPORTING
              im_parent_groups = <lt_parents>.
        ENDIF.

        lv_masterlang = lo_otgr->if_pak_wb_object~get_master_language( ).
        READ TABLE ls_otgr-texts WITH KEY langu = lv_masterlang ASSIGNING <ls_groupt>.
        IF sy-subrc = 0.
          lo_otgr->set_description( <ls_groupt>-text ).
          " ELSE.
          "   Do we want to clear the master language description if not present in the XML conent?
          "   Master Language is non-deterministic - it depends on sy-langu, so rather don't touch
          "   description if the master language is not present
          "   Perhaps, we can display some sort of a message but how?
        ENDIF.

        set_default_package( iv_package ).

        lo_otgr->if_pak_wb_object~save( ).

        lo_otgr->if_pak_wb_object~activate( ).
        lo_otgr->unlock( ).

      CATCH cx_pak_invalid_state cx_pak_invalid_data cx_pak_not_authorized INTO lx_pak_error.
        lo_otgr->unlock( ).

        lv_text = lx_pak_error->get_text( ).
        zcx_abapgit_exception=>raise( |OTGR { ms_item-obj_name }: deserialize: { lv_text }| ).
    ENDTRY.
  ENDMETHOD.