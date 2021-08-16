  METHOD render_order_by_header_cells.

    DATA:
      lv_tmp       TYPE string,
      lv_disp_name TYPE string.

    FIELD-SYMBOLS <ls_col> LIKE LINE OF it_col_spec.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    LOOP AT it_col_spec ASSIGNING <ls_col>.
      " e.g. <th class="ro-detail">Created at [{ gv_time_zone }]</th>
      lv_tmp = '<th'.
      IF <ls_col>-css_class IS NOT INITIAL.
        lv_tmp = lv_tmp && | class="{ <ls_col>-css_class }"|.
      ENDIF.
      lv_tmp = lv_tmp && '>'.

      IF <ls_col>-display_name IS NOT INITIAL.
        lv_disp_name = <ls_col>-display_name.
        IF <ls_col>-add_tz = abap_true.
          lv_disp_name = lv_disp_name && | [{ gv_time_zone }]|.
        ENDIF.
        IF <ls_col>-tech_name = iv_order_by.
          IF iv_order_descending = abap_true.
            lv_tmp = lv_tmp && ri_html->a(
              iv_txt   = lv_disp_name
              iv_act   = |{ zif_abapgit_definitions=>c_action-direction }?direction=ASCENDING|
              iv_title = <ls_col>-title ).
          ELSE.
            lv_tmp = lv_tmp && ri_html->a(
              iv_txt   = lv_disp_name
              iv_act   = |{ zif_abapgit_definitions=>c_action-direction }?direction=DESCENDING|
              iv_title = <ls_col>-title ).
          ENDIF.
        ELSE.
          lv_tmp = lv_tmp && ri_html->a(
            iv_txt   = lv_disp_name
            iv_act   = |{ zif_abapgit_definitions=>c_action-change_order_by }?orderBy={ <ls_col>-tech_name }|
            iv_title = <ls_col>-title ).
        ENDIF.
      ENDIF.
      IF <ls_col>-tech_name = iv_order_by
      AND iv_order_by IS NOT INITIAL.
        IF iv_order_descending = abap_true.
          lv_tmp = lv_tmp && | &#x25B4;|. " arrow up
        ELSE.
          lv_tmp = lv_tmp && | &#x25BE;|. " arrow down
        ENDIF.
      ENDIF.

      lv_tmp = lv_tmp && '</th>'.
      ri_html->add( lv_tmp ).
    ENDLOOP.

  ENDMETHOD.