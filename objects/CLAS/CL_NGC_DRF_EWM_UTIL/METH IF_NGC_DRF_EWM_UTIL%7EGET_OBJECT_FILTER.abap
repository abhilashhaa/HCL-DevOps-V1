METHOD if_ngc_drf_ewm_util~get_object_filter.
  DATA:
    lv_cond      TYPE string,
    lv_line_cond TYPE string.

  LOOP AT it_unfiltered_objects ASSIGNING FIELD-SYMBOL(<is_unfiltered_object>).
    IF rv_result IS NOT INITIAL.
      rv_result = rv_result && | OR |.
    ENDIF.

    " Get condition for filter line

    lv_line_cond = ''.

    " Process all fields
    LOOP AT it_field_names ASSIGNING FIELD-SYMBOL(<is_field_names>).
      ASSIGN COMPONENT <is_field_names>-key_filter_field_name OF STRUCTURE <is_unfiltered_object> TO FIELD-SYMBOL(<is_unf_obj_field>).

      " Check whether the provided field name is valid
      IF <is_unf_obj_field> IS NOT ASSIGNED.
        ASSERT 0 = 1.
      ENDIF.

      " Convert field to condition and append if it has a value
      IF <is_unf_obj_field> IS NOT INITIAL.
        IF lv_line_cond IS NOT INITIAL.
          lv_line_cond = lv_line_cond && | AND |.
        ENDIF.
        lv_cond = <is_unf_obj_field>.
        IF lv_cond CA '*+'.
          TRANSLATE lv_cond USING '*%'.
          TRANSLATE lv_cond USING '+_'.
          lv_cond = |( | && cl_abap_dyn_prg=>escape_quotes( <is_field_names>-check_against_name ) && | LIKE | && cl_abap_dyn_prg=>quote( lv_cond ) && | )|.
        ELSE.
          lv_cond = |( | && cl_abap_dyn_prg=>escape_quotes( <is_field_names>-check_against_name ) && | EQ | && cl_abap_dyn_prg=>quote( lv_cond ) && | )|.
        ENDIF.

        " Append the condition to the current line
        lv_line_cond = lv_line_cond && lv_cond.
      ENDIF.
    ENDLOOP.
    IF lv_line_cond IS NOT INITIAL.
      rv_result = rv_result && |( | && lv_line_cond && | )|.
    ENDIF.
  ENDLOOP.
ENDMETHOD.