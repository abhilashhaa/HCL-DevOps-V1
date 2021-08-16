  METHOD clear_fields.

    FIELD-SYMBOLS: <lg_metadata> TYPE any.

    ASSIGN COMPONENT 'METADATA'
           OF STRUCTURE cg_data
           TO <lg_metadata>.
    ASSERT sy-subrc = 0.

    clear_field( EXPORTING iv_fieldname = 'CHANGED_AT'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'CHANGED_BY'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'CREATED_AT'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'CREATED_BY'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'RESPONSIBLE'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'PACKAGE_REF-NAME'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'CONTAINER_REF-PACKAGE_NAME'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'VERSION'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'RESPONSIBLE'
                 CHANGING  cg_metadata  = <lg_metadata> ).

    clear_field( EXPORTING iv_fieldname = 'MASTER_SYSTEM'
                 CHANGING  cg_metadata  = <lg_metadata> ).

  ENDMETHOD.