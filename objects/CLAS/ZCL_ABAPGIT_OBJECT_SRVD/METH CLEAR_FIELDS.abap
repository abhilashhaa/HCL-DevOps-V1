  METHOD clear_fields.

    clear_field(
      EXPORTING
        iv_fieldname          = 'CONTENT-SOURCE'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_AT'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_BY'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_AT'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_BY'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-MASTER_LANGUAGE'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-RESPONSIBLE'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-DT_UUID'
      CHANGING
        cs_service_definition = cs_service_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-PACKAGE_REF-NAME'
      CHANGING
        cs_service_definition = cs_service_definition ).

  ENDMETHOD.