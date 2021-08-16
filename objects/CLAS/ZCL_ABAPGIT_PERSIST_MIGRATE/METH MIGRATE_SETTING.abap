  METHOD migrate_setting.

    DATA: li_element            TYPE REF TO if_ixml_element,
          ls_setting_to_migrate LIKE LINE OF ct_settings_to_migrate.

    li_element = ci_document->find_from_name( iv_name ).
    IF li_element IS BOUND.

      " The element is present in the global config.
      " Therefore we have to migrate it

      ls_setting_to_migrate-name = iv_name.
      ls_setting_to_migrate-value = li_element->get_value( ).
      INSERT ls_setting_to_migrate INTO TABLE ct_settings_to_migrate.

      li_element->remove_node( ).

    ENDIF.

  ENDMETHOD.