  METHOD render_item_command.

    DATA: lv_difflink TYPE string,
          ls_file     LIKE LINE OF is_item-files.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF is_item-is_dir = abap_true. " Directory

      ri_html->add( '<div>' ).
      ri_html->add( |<span class="grey">{ is_item-changes } changes</span>| ).
      ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state(
        iv_lstate = is_item-lstate
        iv_rstate = is_item-rstate ) ).
      ri_html->add( '</div>' ).

    ELSEIF is_item-changes > 0.

      IF mv_hide_files = abap_true AND is_item-obj_name IS NOT INITIAL.

        lv_difflink = zcl_abapgit_html_action_utils=>obj_encode(
          iv_key    = mo_repo->get_key( )
          ig_object = is_item ).

        ri_html->add( '<div>' ).
        ri_html->add_a( iv_txt = |diff ({ is_item-changes })|
                        iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?{ lv_difflink }| ).
        ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state( iv_lstate = is_item-lstate
                                                            iv_rstate = is_item-rstate ) ).
        ri_html->add( '</div>' ).

      ELSE.
        LOOP AT is_item-files INTO ls_file.

          ri_html->add( '<div>' ).
          IF ls_file-is_changed = abap_true.
            lv_difflink = zcl_abapgit_html_action_utils=>file_encode(
              iv_key  = mo_repo->get_key( )
              ig_file = ls_file ).
            ri_html->add_a( iv_txt = 'diff'
                            iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?{ lv_difflink }| ).
            ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state( iv_lstate = ls_file-lstate
                                                                iv_rstate = ls_file-rstate ) ).
          ELSE.
            ri_html->add( '&nbsp;' ).
          ENDIF.
          ri_html->add( '</div>' ).

        ENDLOOP.
      ENDIF.

    ENDIF.

  ENDMETHOD.