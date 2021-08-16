  METHOD clear_fields.

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_AT'
      CHANGING
        cs_service_binding = cs_service_binding ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_BY'
      CHANGING
        cs_service_binding = cs_service_binding ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-LANGUAGE'
      CHANGING
        cs_service_binding = cs_service_binding ).

  ENDMETHOD.