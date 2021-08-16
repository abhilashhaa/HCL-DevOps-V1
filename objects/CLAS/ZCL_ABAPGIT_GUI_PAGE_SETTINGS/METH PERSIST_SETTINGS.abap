  METHOD persist_settings.

    DATA lo_settings_persistence TYPE REF TO zcl_abapgit_persist_settings.

    lo_settings_persistence = zcl_abapgit_persist_settings=>get_instance( ).
    lo_settings_persistence->modify( mo_settings ).
    MESSAGE 'Settings succesfully saved' TYPE 'S'.

  ENDMETHOD.