  METHOD clear_fields.

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_AT'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_BY'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_AT'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_BY'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-LANGUAGE'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-MASTER_LANGUAGE'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-MASTER_SYSTEM'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-RESPONSIBLE'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-PACKAGE_REF'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'CONTENT-SOURCE'
      CHANGING
        cs_behaviour_definition = cs_behaviour_definition ).

  ENDMETHOD.