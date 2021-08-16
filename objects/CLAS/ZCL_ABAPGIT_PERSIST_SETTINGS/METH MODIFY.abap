  METHOD modify.

    DATA: lv_settings      TYPE string,
          ls_user_settings TYPE zif_abapgit_definitions=>ty_s_user_settings.


    lv_settings = io_settings->get_settings_xml( ).

    zcl_abapgit_persistence_db=>get_instance( )->modify(
      iv_type       = zcl_abapgit_persistence_db=>c_type_settings
      iv_value      = ''
      iv_data       = lv_settings ).

    ls_user_settings = io_settings->get_user_settings( ).

    zcl_abapgit_persistence_user=>get_instance( )->set_settings( ls_user_settings ).

    " Settings have been modified: Update Buffered Settings
    IF mo_settings IS BOUND.
      mo_settings->set_xml_settings( lv_settings ).
      mo_settings->set_user_settings( ls_user_settings ).
    ENDIF.

  ENDMETHOD.