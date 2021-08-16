  METHOD zif_abapgit_object~serialize.
    DATA: lv_text      TYPE string,
          ls_otgr      TYPE ty_otgr,
          lo_otgr      TYPE REF TO cl_cls_object_type_group,
          lx_pak_error TYPE REF TO cx_root,
          lo_parents   TYPE REF TO data.

    FIELD-SYMBOLS: <ls_groupt>  LIKE LINE OF ls_otgr-texts,
                   <ls_element> LIKE LINE OF ls_otgr-elements,
                   <lv_field>   TYPE any,
                   <ls_parent>  TYPE any,
                   <lt_parents> TYPE ANY TABLE.

    lo_otgr = instantiate_and_lock_otgr( ).

*   Description part 1:
*   Dealing with Description of OTGR objects is problematic.
*   The API supports setting of Master Language only and
*   if we want to save also translations we would have to implement
*   our own logic for merging and activation. To keep it simple stupid
*   the current version focuses on the Master language only.
*   If anybody ever runs into the need to version also translation,
*   ask the maintainers of CL_CLS_OBJECT_TYPE_GROUP to add a method for it.
*
*   However, the XML content will pretend we support also translations,
*   so if someone adds support for them in future, there will be no format change.
    APPEND INITIAL LINE TO ls_otgr-texts ASSIGNING <ls_groupt>.

    " Parents (cls_tygr_parent) does not exist in lower releases
    TRY.
        CREATE DATA lo_parents TYPE TABLE OF ('CLS_TYGR_PARENT').
        ASSIGN lo_parents->* TO <lt_parents>.
      CATCH cx_sy_create_data_error.
    ENDTRY.

    TRY.
        ls_otgr-cls_type_group-name = lo_otgr->if_cls_object_type_group~get_name( ).
        ls_otgr-cls_type_group-proxy_flag = lo_otgr->if_cls_object_type_group~get_proxy_filter( ).
        lo_otgr->get_elements( IMPORTING ex_elements = ls_otgr-elements ).

        IF <lt_parents> IS ASSIGNED.
          CALL METHOD lo_otgr->('IF_CLS_OBJECT_TYPE_GROUP~GET_PARENT_GROUPS')
            EXPORTING
              im_explicit_parents_only = abap_true
            IMPORTING
              ex_parent_groups         = <lt_parents>.
        ENDIF.

        " Beware: the following method returns the Master Language description only if the object is Locked!
        <ls_groupt>-text = lo_otgr->if_cls_object_type_group~get_description( ).
        <ls_groupt>-langu = lo_otgr->if_pak_wb_object~get_master_language( ).

        lo_otgr->unlock( ).

      CATCH cx_pak_invalid_state cx_pak_invalid_data cx_pak_not_authorized INTO lx_pak_error.
        lo_otgr->unlock( ).

        lv_text = lx_pak_error->get_text( ).
        zcx_abapgit_exception=>raise( |OTGR { ms_item-obj_name }: serialize: { lv_text }| ).
    ENDTRY.

    CLEAR: ls_otgr-cls_type_group-created_by,
           ls_otgr-cls_type_group-created_on,
           ls_otgr-cls_type_group-changed_by,
           ls_otgr-cls_type_group-changed_on.

*    Description part 2:
*
* lt_lang_sel  TYPE RANGE OF langu,
* ls_lang_sel  LIKE LINE OF lt_lang_sel,
*
*    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
*      ls_lang_sel-low = mv_language.
*      ls_lang_sel-sign = 'I'.
*      ls_lang_sel-option = 'EQ'.
*    ENDIF.
*
*    SELECT * FROM cls_type_groupt INTO TABLE ls_otgr-texts
*      WHERE name = ms_item-obj_name
*        AND activation_state = 'A'
*        AND langu in lt_lang_sel.
*
*   Description ideas end

    LOOP AT ls_otgr-texts ASSIGNING <ls_groupt>.
      " Not necessary as we serialize only Active
      CLEAR <ls_groupt>-activation_state.
      " Not necessary as we have it in the root XML node
      CLEAR <ls_groupt>-name.
    ENDLOOP.

    LOOP AT ls_otgr-elements ASSIGNING <ls_element>.
      " Not necessary as we serialize only Active
      CLEAR <ls_element>-activation_state.
      " Not necessary as we have it in the root XML node
      CLEAR <ls_element>-obj_type_group.
    ENDLOOP.

    io_xml->add( iv_name = 'OTGR'
                 ig_data = ls_otgr ).

    IF <lt_parents> IS ASSIGNED.
      LOOP AT <lt_parents> ASSIGNING <ls_parent>.
        ASSIGN COMPONENT 'ACTIVATION_STATE' OF STRUCTURE <ls_parent> TO <lv_field>.
        IF sy-subrc = 0.
          " Not necessary as we serialize only Active
          CLEAR <lv_field>.
        ENDIF.
        ASSIGN COMPONENT 'OBJ_TYPE_GROUP' OF STRUCTURE <ls_parent> TO <lv_field>.
        IF sy-subrc = 0.
          " Not necessary as we have it in the root XML node
          CLEAR <lv_field>.
        ENDIF.
      ENDLOOP.

      io_xml->add( iv_name = 'PARENTS'
                   ig_data = <lt_parents> ).
    ENDIF.

  ENDMETHOD.