  METHOD zif_abapgit_popups~popup_package_export.

    DATA: lt_fields       TYPE TABLE OF sval.
    DATA: lv_package      TYPE spo_value.
    DATA: lv_folder_logic TYPE spo_value.
    DATA: lv_serialize_master_lang_only TYPE spo_value.

    add_field( EXPORTING iv_tabname   = 'TDEVC'
                         iv_fieldname = 'DEVCLASS'
                         iv_fieldtext = 'Package'
               CHANGING  ct_fields    = lt_fields ).

    add_field( EXPORTING iv_tabname   = 'TDEVC'
                         iv_fieldname = 'INTSYS'
                         iv_fieldtext = 'Folder logic'
                         iv_value     = 'PREFIX'
               CHANGING  ct_fields    = lt_fields ).

    add_field( EXPORTING iv_tabname   = 'TVDIR'
                         iv_fieldname = 'FLAG'
                         iv_fieldtext = 'Master lang only'
               CHANGING  ct_fields    = lt_fields ).

    TRY.

        _popup_3_get_values( EXPORTING iv_popup_title    = 'Export package'
                                       iv_no_value_check = abap_true
                             IMPORTING ev_value_1        = lv_package
                                       ev_value_2        = lv_folder_logic
                                       ev_value_3        = lv_serialize_master_lang_only
                             CHANGING  ct_fields         = lt_fields ).

        ev_package = to_upper( lv_package ).
        ev_folder_logic = to_upper( lv_folder_logic ).
        ev_serialize_master_lang_only = boolc( lv_serialize_master_lang_only IS NOT INITIAL ).

      CATCH zcx_abapgit_cancel.
    ENDTRY.

  ENDMETHOD.