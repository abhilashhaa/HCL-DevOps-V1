  METHOD zif_abapgit_popups~create_branch_popup.

    DATA: lt_fields TYPE TABLE OF sval.
    DATA: lv_name   TYPE spo_value.

    CLEAR: ev_name, ev_cancel.

    add_field( EXPORTING iv_tabname   = 'TEXTL'
                         iv_fieldname = 'LINE'
                         iv_fieldtext = 'Name'
                         iv_value     = 'new-branch-name'
               CHANGING  ct_fields    = lt_fields ).

    TRY.

        _popup_3_get_values(
          EXPORTING iv_popup_title = |Create branch from {
            zcl_abapgit_git_branch_list=>get_display_name( iv_source_branch_name ) }|
          IMPORTING ev_value_1     = lv_name
          CHANGING  ct_fields      = lt_fields ).

        ev_name = zcl_abapgit_git_branch_list=>complete_heads_branch_name(
              zcl_abapgit_git_branch_list=>normalize_branch_name( lv_name ) ).

      CATCH zcx_abapgit_cancel.
        ev_cancel = abap_true.
    ENDTRY.

  ENDMETHOD.