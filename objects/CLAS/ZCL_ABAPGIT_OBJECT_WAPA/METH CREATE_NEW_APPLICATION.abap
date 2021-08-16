  METHOD create_new_application.

    DATA: ls_item   LIKE ms_item,
          lv_objkey TYPE seu_objkey.

    cl_o2_api_application=>create_new(
      EXPORTING
        p_application_data      = is_attributes
        p_nodes                 = it_nodes
        p_navgraph              = it_navgraph
      IMPORTING
        p_application           = ro_bsp
      EXCEPTIONS
        object_already_existing = 1
        object_just_created     = 2
        not_authorized          = 3
        undefined_name          = 4
        author_not_existing     = 5
        action_cancelled        = 6
        error_occured           = 7
        invalid_parameter       = 8 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |WAPA - error from create_new: { sy-subrc }| ).
    ENDIF.

    ro_bsp->save( ).

    ro_bsp->set_changeable(
      p_changeable           = abap_false
      p_complete_application = abap_true ).

    ls_item-obj_type = 'WAPD'.
    ls_item-obj_name = ms_item-obj_name.
    zcl_abapgit_objects_activation=>add_item( ls_item ).

    lv_objkey = ls_item-obj_name.
* todo, hmm, the WAPD is not added to the worklist during activation
    cl_o2_api_application=>activate( lv_objkey ).


  ENDMETHOD.