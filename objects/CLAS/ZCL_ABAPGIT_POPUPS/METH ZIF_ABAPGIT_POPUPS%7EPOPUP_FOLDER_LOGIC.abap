  METHOD zif_abapgit_popups~popup_folder_logic.

    DATA: lt_fields       TYPE TABLE OF sval.
    DATA: lv_folder_logic TYPE spo_value.

    CLEAR: rv_folder_logic.

    add_field( EXPORTING iv_tabname   = 'TDEVC'
                         iv_fieldname = 'INTSYS'
                         iv_fieldtext = 'Folder logic'
                         iv_value     = 'PREFIX'
               CHANGING  ct_fields    = lt_fields ).

    TRY.

        _popup_3_get_values( EXPORTING iv_popup_title    = 'Export package'
                                       iv_no_value_check = abap_true
                             IMPORTING ev_value_1        = lv_folder_logic
                             CHANGING  ct_fields         = lt_fields ).

        rv_folder_logic = to_upper( lv_folder_logic ).

      CATCH zcx_abapgit_cancel.
    ENDTRY.

  ENDMETHOD.