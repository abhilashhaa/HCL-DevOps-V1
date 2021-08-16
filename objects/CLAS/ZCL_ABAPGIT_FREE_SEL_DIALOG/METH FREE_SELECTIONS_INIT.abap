  METHOD free_selections_init.
    CALL FUNCTION 'FREE_SELECTIONS_INIT'
      EXPORTING
        kind                     = 'F'
        field_ranges_int         = it_default_values
        restriction              = is_restriction
      IMPORTING
        selection_id             = ev_selection_id
      TABLES
        fields_tab               = ct_fields
        field_texts              = ct_field_texts
      EXCEPTIONS
        fields_incomplete        = 1
        fields_no_join           = 2
        field_not_found          = 3
        no_tables                = 4
        table_not_found          = 5
        expression_not_supported = 6
        incorrect_expression     = 7
        illegal_kind             = 8
        area_not_found           = 9
        inconsistent_area        = 10
        kind_f_no_fields_left    = 11
        kind_f_no_fields         = 12
        too_many_fields          = 13
        dup_field                = 14
        field_no_type            = 15
        field_ill_type           = 16
        dup_event_field          = 17
        node_not_in_ldb          = 18
        area_no_field            = 19
        OTHERS                   = 20.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from FREE_SELECTIONS_INIT: { sy-subrc }| ).
    ENDIF.
  ENDMETHOD.