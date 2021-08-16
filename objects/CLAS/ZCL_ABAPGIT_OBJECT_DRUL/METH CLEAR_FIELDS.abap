  METHOD clear_fields.

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_AT'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_BY'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_AT'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_BY'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-MASTER_LANGUAGE'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-RESPONSIBLE'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-PACKAGE_REF'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'CONTENT-SOURCE'
      CHANGING
        cs_dependency_rule = cs_dependency_rule ).

  ENDMETHOD.