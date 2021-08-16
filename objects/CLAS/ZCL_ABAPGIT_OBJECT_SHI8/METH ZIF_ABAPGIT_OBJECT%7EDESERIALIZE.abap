  METHOD zif_abapgit_object~deserialize.

    DATA: ls_assignment_data TYPE ttree_sfw_nodes,
          ls_node_data       TYPE hier_iface,
          lv_saved           TYPE abap_bool,
          ls_message         TYPE hier_mess.

    io_xml->read(
      EXPORTING
        iv_name = 'SHI8'
      CHANGING
        cg_data = ls_assignment_data ).

    ls_node_data-tree_id = ls_assignment_data-tree_id.
    ls_node_data-node_id = ls_assignment_data-node_id.

    CALL FUNCTION 'STREE_SFW_ASSIGNMENT_SAVE'
      EXPORTING
        assignment_id = ls_assignment_data-sfw_ass_id
        switch_id     = ls_assignment_data-switch_id
        reaction      = ls_assignment_data-reaction
        node_data     = ls_node_data
      IMPORTING
        data_saved    = lv_saved
        message       = ls_message.

    IF lv_saved = abap_false.
      zcx_abapgit_exception=>raise( |{ ls_message-msgtxt }| ).
    ENDIF.

  ENDMETHOD.