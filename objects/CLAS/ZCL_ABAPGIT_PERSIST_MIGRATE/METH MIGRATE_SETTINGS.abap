  METHOD migrate_settings.

    DATA: li_global_settings_document TYPE REF TO if_ixml_document,
          lt_settings_to_migrate      TYPE tty_settings_to_migrate,
          lx_error                    TYPE REF TO zcx_abapgit_not_found.

    " migrate global settings to user specific settings

    TRY.
        li_global_settings_document = get_global_settings_document( ).

      CATCH zcx_abapgit_not_found INTO lx_error.
        " No global settings available, nothing todo.
        RETURN.
    ENDTRY.

    migrate_setting(
      EXPORTING
        iv_name                = |MAX_LINES|
      CHANGING
        ct_settings_to_migrate = lt_settings_to_migrate
        ci_document            = li_global_settings_document ).

    migrate_setting(
      EXPORTING
        iv_name                = |ADT_JUMP_ENABLED|
      CHANGING
        ct_settings_to_migrate = lt_settings_to_migrate
        ci_document            = li_global_settings_document ).

    IF lines( lt_settings_to_migrate ) > 0.

      distribute_settings_to_users( lt_settings_to_migrate ).

      update_global_settings( li_global_settings_document ).

    ENDIF.

  ENDMETHOD.