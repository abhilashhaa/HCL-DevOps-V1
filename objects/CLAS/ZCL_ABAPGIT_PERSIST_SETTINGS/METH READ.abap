  METHOD read.

    IF mo_settings IS BOUND.
      " Return Buffered Settings
      ro_settings = mo_settings.
      RETURN.
    ENDIF.

    " Settings have changed or have not yet been loaded
    CREATE OBJECT ro_settings.

    TRY.

        ro_settings->set_xml_settings(
          zcl_abapgit_persistence_db=>get_instance( )->read(
            iv_type  = zcl_abapgit_persistence_db=>c_type_settings
            iv_value = '' ) ).

        ro_settings->set_user_settings( zcl_abapgit_persistence_user=>get_instance( )->get_settings( ) ).

      CATCH zcx_abapgit_not_found zcx_abapgit_exception.

        ro_settings->set_defaults( ).

    ENDTRY.

    mo_settings = ro_settings.

  ENDMETHOD.