  PRIVATE SECTION.
    TYPES:
      ty_field_text_tab TYPE STANDARD TABLE OF rsdstexts WITH DEFAULT KEY.
    METHODS:
      convert_input_fields EXPORTING et_default_values TYPE rsds_trange
                                     es_restriction    TYPE sscr_restrict_ds
                                     et_fields         TYPE rsdsfields_t
                                     et_field_texts    TYPE ty_field_text_tab,
      free_selections_init IMPORTING it_default_values TYPE rsds_trange
                                     is_restriction    TYPE sscr_restrict_ds
                           EXPORTING ev_selection_id   TYPE dynselid
                           CHANGING  ct_fields         TYPE rsdsfields_t
                                     ct_field_texts    TYPE ty_field_text_tab
                           RAISING   zcx_abapgit_exception,
      free_selections_dialog IMPORTING iv_selection_id  TYPE dynselid
                             EXPORTING et_result_ranges TYPE rsds_trange
                             CHANGING  ct_fields        TYPE rsdsfields_t
                             RAISING   zcx_abapgit_cancel
                                       zcx_abapgit_exception,
      validate_results IMPORTING it_result_ranges TYPE rsds_trange
                       RAISING   zcx_abapgit_exception,
      transfer_results_to_input IMPORTING it_result_ranges TYPE rsds_trange.
    DATA:
      mr_fields     TYPE REF TO ty_free_sel_field_tab,
      mv_title      TYPE ty_syst_title,
      mv_frame_text TYPE ty_syst_title.