  METHOD constructor.
    super->constructor( ).
    CREATE OBJECT mo_validation_log.
    CREATE OBJECT mo_form_data.
    mo_form = get_form_schema( ).
  ENDMETHOD.