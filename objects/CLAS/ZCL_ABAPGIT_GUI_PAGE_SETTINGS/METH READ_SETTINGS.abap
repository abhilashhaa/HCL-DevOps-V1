  METHOD read_settings.

    DATA lo_settings_persistence TYPE REF TO zcl_abapgit_persist_settings.

    lo_settings_persistence = zcl_abapgit_persist_settings=>get_instance( ).
    mo_settings = lo_settings_persistence->read( ).

    mt_proxy_bypass = mo_settings->get_proxy_bypass( ).

  ENDMETHOD.