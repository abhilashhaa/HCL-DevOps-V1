  METHOD process_package.

    DATA:
      lv_packsel_whr     TYPE string,
      lt_refchar_node    TYPE ltt_nodekey,
      lt_reftabs         TYPE ltt_reftabs,
      lv_refval_exists   TYPE boole_d,
      lt_delete_ausp     TYPE ltt_delete_ausp,
      lv_num_del_entries TYPE i.

    mo_conv_logger->init_logger_pp( mv_appl_name ).

    DATA(lv_packcnt) = lines( it_packsel ).
    mo_conv_logger->log_message(
      iv_id     = 'UPGBA'
      iv_type   = 'I'
      iv_number = '034'
      iv_param1 = 'Received'
      iv_param2 = CONV #( lv_packcnt )
      iv_param3 = 'packages to be processed'
    ) ##NO_TEXT.

    mo_conv_util->new_page_print_on( ms_print_parameters ).

    mo_conv_util->write_spool( `Business Object                                                                            Class Type Characteristic                ` ) ##NO_TEXT.
    mo_conv_util->write_spool( `------------------------------------------------------------------------------------------------------------------------------------` ) ##NO_TEXT.
    mo_conv_logger->log_message(
      iv_id     = 'UPGBA'
      iv_type   = 'W'
      iv_number = '034'
      iv_param1 = `Enumerating into Spool number `
      iv_param2 = CONV #( sy-spono )
      iv_param3 = `. You can view it with tx. SP02.`
    ) ##NO_TEXT.

    " We might get multiple packages into one worker process / this is auto tuned by PFW.
    LOOP AT it_packsel REFERENCE INTO DATA(lr_packsel).
      CLEAR: lt_refchar_node, lt_delete_ausp.

      mo_conv_logger->log_message(
        iv_id     = 'UPGBA'
        iv_type   = 'I'
        iv_number = '036'
        iv_param1 = CONV #( lr_packsel->packno )
        iv_param2 = cl_ngc_core_data_conv=>get_current_time( )
      ) ##NO_TEXT.

      " Convert the package selection criteria into a WHERE clause.
      lv_packsel_whr = mo_pfw_util->combine_seltabs( lr_packsel->selection ).

      " Read the Reference Characteristic relevant - UNPROCESSED / ALL - BOs.
      TEST-SEAM select_cds_seam.
        SELECT *
          FROM (gv_refchars_name)                        "#EC CI_DYNTAB
          CLIENT SPECIFIED                               "#EC CI_CLIENT
          WHERE (lv_packsel_whr)                         "#EC CI_DYNWHERE
          INTO CORRESPONDING FIELDS OF TABLE @lt_refchar_node.
      END-TEST-SEAM.

      LOOP AT lt_refchar_node REFERENCE INTO DATA(lr_refchar_node)
        GROUP BY (
          obtab = lr_refchar_node->obtab
          objek = lr_refchar_node->objek
          datuv = lr_refchar_node->datuv )
        REFERENCE INTO DATA(lr_refchar_node_groupkey).

        lt_reftabs = me->read_ref_values(
          EXPORTING
            iv_obtab   = lr_refchar_node_groupkey->obtab
            iv_objek   = lr_refchar_node_groupkey->objek
            iv_datuv   = lr_refchar_node_groupkey->datuv
          CHANGING
            ct_events  = rt_events
        ).

        IF lt_reftabs IS NOT INITIAL.
          LOOP AT GROUP lr_refchar_node_groupkey REFERENCE INTO DATA(lr_refchar_node_groupmember).
            lv_refval_exists = me->refval_exists(
              it_reftabs = lt_reftabs
              iv_attab   = lr_refchar_node_groupmember->attab
              iv_atfel   = lr_refchar_node_groupmember->atfel
            ).

            IF lv_refval_exists = abap_true.
              IF mv_testmode = abap_true.
                INSERT VALUE #(
                  trueobjek = lr_refchar_node_groupmember->objek
                  klart     = lr_refchar_node_groupmember->klart
                  atnam     = lr_refchar_node_groupmember->atnam
                ) INTO TABLE lt_delete_ausp.
              ELSE.
                INSERT VALUE #(
                  trueobjek = lr_refchar_node_groupmember->objek
                  objek     = lr_refchar_node_groupmember->auspobjek
                  klart     = lr_refchar_node_groupmember->klart
                  atinn     = lr_refchar_node_groupmember->atinn
                  atnam     = lr_refchar_node_groupmember->atnam
                ) INTO TABLE lt_delete_ausp.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDLOOP.

      LOOP AT lt_delete_ausp REFERENCE INTO DATA(lr_delete_ausp).
        DATA lv_text TYPE string.

        CONCATENATE lr_delete_ausp->trueobjek lr_delete_ausp->klart `      ` lr_delete_ausp->atnam INTO lv_text SEPARATED BY space RESPECTING BLANKS.
        mo_conv_util->write_spool( lv_text ).
      ENDLOOP.

      IF mv_testmode = abap_true.
        lv_num_del_entries = lines( lt_delete_ausp ).
      ELSE.
        lv_num_del_entries = me->delete_ausp( lt_delete_ausp ).
      ENDIF.

      ASSIGN rt_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_num_del_entries  param = '' ] TO FIELD-SYMBOL(<ls_event>).

      IF sy-subrc IS INITIAL.
        <ls_event>-count += lv_num_del_entries.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_num_del_entries param = '' count = lv_num_del_entries ) TO rt_events.
      ENDIF.

      mo_conv_logger->log_message(
        iv_id     = 'UPGBA'
        iv_type   = 'I'
        iv_number = '037'
        iv_param1 = CONV #( lr_packsel->packno )
        iv_param2 = cl_ngc_core_data_conv=>get_current_time( )
      ) ##NO_TEXT.

      IF mv_testmode = abap_true.
        mo_conv_util->db_rollback( ).
      ELSE.
        mo_conv_util->db_commit( ).
      ENDIF.
    ENDLOOP.

    " We need an event for all the non existent OBJECT_CHECKs.
    LOOP AT mt_object_check_names REFERENCE INTO DATA(lr_object_check_names) WHERE fkbname = gc_no_name.
      IF NOT line_exists( rt_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_obj_chk_nexist   param = lr_object_check_names->obtab ] ).
        APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_obj_chk_nexist param = lr_object_check_names->obtab count = 1 ) TO rt_events.
      ENDIF.
    ENDLOOP.

    mo_conv_util->new_page_print_off( ).

    mo_conv_logger->close( ).

  ENDMETHOD.