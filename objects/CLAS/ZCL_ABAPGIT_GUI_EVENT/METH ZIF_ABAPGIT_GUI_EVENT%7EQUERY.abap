  METHOD zif_abapgit_gui_event~query.

    DATA lt_fields TYPE tihttpnvp.

    IF iv_upper_cased = abap_true.
      IF mo_query_upper_cased IS NOT BOUND.
        mo_query_upper_cased = fields_to_map(
          zcl_abapgit_html_action_utils=>parse_fields_upper_case_name( zif_abapgit_gui_event~mv_getdata ) ).
        mo_query_upper_cased->freeze( ).
      ENDIF.
      ro_string_map = mo_query_upper_cased.
    ELSE.
      IF mo_query IS NOT BOUND.
        mo_query = fields_to_map(
          zcl_abapgit_html_action_utils=>parse_fields( zif_abapgit_gui_event~mv_getdata ) ).
        mo_query->freeze( ).
      ENDIF.
      ro_string_map = mo_query.
    ENDIF.

  ENDMETHOD.