  METHOD clear_fields.

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_AT'
      CHANGING
        cs_logical_db_schema = cs_logical_db_schema ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CREATED_BY'
      CHANGING
        cs_logical_db_schema = cs_logical_db_schema ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_AT'
      CHANGING
        cs_logical_db_schema = cs_logical_db_schema ).

    clear_field(
      EXPORTING
        iv_fieldname          = 'METADATA-CHANGED_BY'
      CHANGING
        cs_logical_db_schema = cs_logical_db_schema ).

  ENDMETHOD.