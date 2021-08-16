  METHOD validate_results.
    DATA: ls_error_msg      TYPE symsg,
          lv_ddut_fieldname TYPE fnam_____4,
          lv_value          TYPE rsdsselop_.
    FIELD-SYMBOLS: <ls_result_range_for_tab> TYPE rsds_range,
                   <ls_result_range_line>    TYPE rsds_frange,
                   <ls_input_field>          TYPE ty_free_sel_field,
                   <lt_input_fields>         TYPE ty_free_sel_field_tab,
                   <ls_selopt_line>          TYPE rsdsselopt.

    ASSIGN mr_fields->* TO <lt_input_fields>.
    ASSERT sy-subrc = 0.

    LOOP AT it_result_ranges ASSIGNING <ls_result_range_for_tab>.
      LOOP AT <ls_result_range_for_tab>-frange_t ASSIGNING <ls_result_range_line>.
        READ TABLE <lt_input_fields> WITH KEY ddic_tabname = <ls_result_range_for_tab>-tablename
                                              ddic_fieldname = <ls_result_range_line>-fieldname
                                     ASSIGNING <ls_input_field>.
        ASSERT sy-subrc = 0.
        IF <ls_input_field>-only_parameter = abap_false.
          CONTINUE.
        ENDIF.

        CASE lines( <ls_result_range_line>-selopt_t ).
          WHEN 0.
            CLEAR lv_value.
          WHEN 1.
            READ TABLE <ls_result_range_line>-selopt_t INDEX 1 ASSIGNING <ls_selopt_line>.
            ASSERT sy-subrc = 0.
            lv_value = <ls_selopt_line>-low.
          WHEN OTHERS.
            ASSERT 1 = 2.
        ENDCASE.

        CLEAR ls_error_msg.
        lv_ddut_fieldname = <ls_input_field>-ddic_fieldname.

        CALL FUNCTION 'DDUT_INPUT_CHECK'
          EXPORTING
            tabname            = <ls_input_field>-ddic_tabname
            fieldname          = lv_ddut_fieldname
            value              = lv_value
            accept_all_initial = abap_true
            value_list         = 'S'
          IMPORTING
            msgid              = ls_error_msg-msgid
            msgty              = ls_error_msg-msgty
            msgno              = ls_error_msg-msgno
            msgv1              = ls_error_msg-msgv1
            msgv2              = ls_error_msg-msgv2
            msgv3              = ls_error_msg-msgv3
            msgv4              = ls_error_msg-msgv4.
        IF ls_error_msg IS NOT INITIAL.
          zcx_abapgit_exception=>raise_t100(
            iv_msgid = ls_error_msg-msgid
            iv_msgno = ls_error_msg-msgno
            iv_msgv1 = ls_error_msg-msgv1
            iv_msgv2 = ls_error_msg-msgv2
            iv_msgv3 = ls_error_msg-msgv3
            iv_msgv4 = ls_error_msg-msgv4 ).
        ELSEIF <ls_input_field>-param_obligatory = abap_true AND lv_value IS INITIAL.
          zcx_abapgit_exception=>raise( |Field '{ <ls_input_field>-name }' is obligatory| ).
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.