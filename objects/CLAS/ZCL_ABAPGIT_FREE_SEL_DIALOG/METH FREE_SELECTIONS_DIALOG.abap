  METHOD free_selections_dialog.
    CALL FUNCTION 'FREE_SELECTIONS_DIALOG'
      EXPORTING
        selection_id    = iv_selection_id
        title           = mv_title
        frame_text      = mv_frame_text
        status          = 1
        as_window       = abap_true
        no_intervals    = abap_true
        tree_visible    = abap_false
      IMPORTING
        field_ranges    = et_result_ranges
      TABLES
        fields_tab      = ct_fields
      EXCEPTIONS
        internal_error  = 1
        no_action       = 2
        selid_not_found = 3
        illegal_status  = 4
        OTHERS          = 5.
    CASE sy-subrc.
      WHEN 0 ##NEEDED.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_abapgit_cancel.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |Error from FREE_SELECTIONS_DIALOG: { sy-subrc }| ).
    ENDCASE.
  ENDMETHOD.