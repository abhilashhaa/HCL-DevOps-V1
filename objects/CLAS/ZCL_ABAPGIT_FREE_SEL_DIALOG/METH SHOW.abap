  METHOD show.
    DATA: lt_default_values   TYPE rsds_trange,
          ls_restriction      TYPE sscr_restrict_ds,
          lt_fields           TYPE rsdsfields_t,
          lt_field_texts      TYPE ty_field_text_tab,
          lv_repeat_dialog    TYPE abap_bool VALUE abap_true,
          lv_selection_id     TYPE dynselid,
          lt_results          TYPE rsds_trange,
          lx_validation_error TYPE REF TO zcx_abapgit_exception.

    convert_input_fields(
      IMPORTING
        et_default_values = lt_default_values
        es_restriction    = ls_restriction
        et_fields         = lt_fields
        et_field_texts    = lt_field_texts ).

    WHILE lv_repeat_dialog = abap_true.
      lv_repeat_dialog = abap_false.

      free_selections_init(
        EXPORTING
          it_default_values = lt_default_values
          is_restriction    = ls_restriction
        IMPORTING
          ev_selection_id   = lv_selection_id
        CHANGING
          ct_fields         = lt_fields
          ct_field_texts    = lt_field_texts ).

      free_selections_dialog(
        EXPORTING
          iv_selection_id  = lv_selection_id
        IMPORTING
          et_result_ranges = lt_results
        CHANGING
          ct_fields        = lt_fields ).

      TRY.
          validate_results( lt_results ).
        CATCH zcx_abapgit_exception INTO lx_validation_error.
          lv_repeat_dialog = abap_true.
          lt_default_values = lt_results.
          MESSAGE lx_validation_error TYPE 'I' DISPLAY LIKE 'E'.
          CONTINUE.
      ENDTRY.

      transfer_results_to_input( lt_results ).
    ENDWHILE.
  ENDMETHOD.