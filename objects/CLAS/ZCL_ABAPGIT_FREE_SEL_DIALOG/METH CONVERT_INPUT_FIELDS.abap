  METHOD convert_input_fields.
    CONSTANTS: lc_only_eq_optlist_name TYPE c LENGTH 10 VALUE 'ONLYEQ'.
    DATA: ls_parameter_opt_list TYPE sscr_opt_list.
    FIELD-SYMBOLS: <ls_input_field>            TYPE ty_free_sel_field,
                   <lt_input_fields>           TYPE ty_free_sel_field_tab,
                   <ls_free_sel_field>         TYPE rsdsfields,
                   <ls_restriction_ass>        TYPE sscr_ass_ds,
                   <ls_text>                   TYPE rsdstexts,
                   <ls_default_value>          TYPE rsds_range,
                   <ls_default_value_range>    TYPE rsds_frange,
                   <ls_default_val_range_line> TYPE rsdsselopt.

    ASSERT mr_fields IS BOUND.
    ASSIGN mr_fields->* TO <lt_input_fields>.

    LOOP AT <lt_input_fields> ASSIGNING <ls_input_field>.
      APPEND INITIAL LINE TO et_fields ASSIGNING <ls_free_sel_field>.
      <ls_free_sel_field>-fieldname = <ls_input_field>-ddic_fieldname.
      <ls_free_sel_field>-tablename = <ls_input_field>-ddic_tabname.

      IF <ls_input_field>-only_parameter = abap_true.
        IF es_restriction IS INITIAL.
          ls_parameter_opt_list-name = lc_only_eq_optlist_name.
          ls_parameter_opt_list-options-eq = abap_true.
          APPEND ls_parameter_opt_list TO es_restriction-opt_list_tab.
        ENDIF.

        APPEND INITIAL LINE TO es_restriction-ass_tab ASSIGNING <ls_restriction_ass>.
        <ls_restriction_ass>-kind = 'S'.
        <ls_restriction_ass>-fieldname = <ls_input_field>-ddic_fieldname.
        <ls_restriction_ass>-tablename = <ls_input_field>-ddic_tabname.
        <ls_restriction_ass>-sg_main = 'I'.
        <ls_restriction_ass>-sg_addy = 'N'.
        <ls_restriction_ass>-op_main = lc_only_eq_optlist_name.
      ENDIF.

      IF <ls_input_field>-text IS NOT INITIAL.
        APPEND INITIAL LINE TO et_field_texts ASSIGNING <ls_text>.
        <ls_text>-fieldname = <ls_input_field>-ddic_fieldname.
        <ls_text>-tablename = <ls_input_field>-ddic_tabname.
        <ls_text>-text = <ls_input_field>-text.
      ENDIF.

      IF <ls_input_field>-value IS NOT INITIAL OR <ls_input_field>-value_range IS NOT INITIAL.
        READ TABLE et_default_values WITH KEY tablename = <ls_input_field>-ddic_tabname
                                     ASSIGNING <ls_default_value>.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO et_default_values ASSIGNING <ls_default_value>.
          <ls_default_value>-tablename = <ls_input_field>-ddic_tabname.
        ENDIF.

        APPEND INITIAL LINE TO <ls_default_value>-frange_t ASSIGNING <ls_default_value_range>.
        <ls_default_value_range>-fieldname = <ls_input_field>-ddic_fieldname.

        IF <ls_input_field>-value IS NOT INITIAL.
          APPEND INITIAL LINE TO <ls_default_value_range>-selopt_t ASSIGNING <ls_default_val_range_line>.
          <ls_default_val_range_line>-sign = 'I'.
          <ls_default_val_range_line>-option = 'EQ'.
          <ls_default_val_range_line>-low = <ls_input_field>-value.
        ELSEIF <ls_input_field>-value_range IS NOT INITIAL.
          <ls_default_value_range>-selopt_t = <ls_input_field>-value_range.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.