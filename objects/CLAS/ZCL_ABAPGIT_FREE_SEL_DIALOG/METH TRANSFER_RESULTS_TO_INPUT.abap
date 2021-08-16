  METHOD transfer_results_to_input.
    FIELD-SYMBOLS: <ls_input_field>          TYPE ty_free_sel_field,
                   <lt_input_fields>         TYPE ty_free_sel_field_tab,
                   <ls_result_range_for_tab> TYPE rsds_range,
                   <ls_result_range_line>    TYPE rsds_frange,
                   <ls_selopt_line>          TYPE rsdsselopt.

    ASSIGN mr_fields->* TO <lt_input_fields>.
    ASSERT sy-subrc = 0.

    LOOP AT <lt_input_fields> ASSIGNING <ls_input_field>.
      READ TABLE it_result_ranges WITH KEY tablename = <ls_input_field>-ddic_tabname
                                  ASSIGNING <ls_result_range_for_tab>.
      IF sy-subrc = 0.
        READ TABLE <ls_result_range_for_tab>-frange_t WITH KEY fieldname = <ls_input_field>-ddic_fieldname
                                                      ASSIGNING <ls_result_range_line>.
        IF sy-subrc = 0 AND <ls_result_range_line>-selopt_t IS NOT INITIAL.
          IF <ls_input_field>-only_parameter = abap_true.
            ASSERT lines( <ls_result_range_line>-selopt_t ) = 1.

            READ TABLE <ls_result_range_line>-selopt_t INDEX 1 ASSIGNING <ls_selopt_line>.
            ASSERT sy-subrc = 0.

            ASSERT <ls_selopt_line>-sign = 'I' AND
                   <ls_selopt_line>-option = 'EQ' AND
                   <ls_selopt_line>-high IS INITIAL.

            <ls_input_field>-value = <ls_selopt_line>-low.
          ELSE.
            <ls_input_field>-value_range = <ls_result_range_line>-selopt_t.
          ENDIF.
        ELSE.
          CLEAR: <ls_input_field>-value, <ls_input_field>-value_range.
        ENDIF.
      ELSE.
        CLEAR: <ls_input_field>-value, <ls_input_field>-value_range.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.