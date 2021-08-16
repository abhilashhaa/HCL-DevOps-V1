  METHOD fill_metadata_from_db.

    DATA:
      li_wb_object_operator       TYPE REF TO object,
      lr_behaviour_definition_old TYPE REF TO data.

    FIELD-SYMBOLS:
      <ls_behaviour_definition_old> TYPE any,
      <lv_created_at>               TYPE xsddatetime_z,
      <lv_created_by>               TYPE syuname,
      <lv_created_at_old>           TYPE xsddatetime_z,
      <lv_created_by_old>           TYPE syuname.

    li_wb_object_operator = get_wb_object_operator( ).

    CREATE DATA lr_behaviour_definition_old TYPE ('CL_BLUE_SOURCE_OBJECT_DATA=>TY_OBJECT_DATA').
    ASSIGN lr_behaviour_definition_old->* TO <ls_behaviour_definition_old>.
    ASSERT sy-subrc = 0.

    CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~READ')
      IMPORTING
        data = <ls_behaviour_definition_old>.

    ASSIGN COMPONENT 'METADATA-CREATED_BY' OF STRUCTURE cs_behaviour_definition
           TO <lv_created_by>.
    ASSERT sy-subrc = 0.

    ASSIGN COMPONENT 'METADATA-CREATED_AT' OF STRUCTURE cs_behaviour_definition
           TO <lv_created_at>.
    ASSERT sy-subrc = 0.

    ASSIGN COMPONENT 'METADATA-CREATED_BY' OF STRUCTURE <ls_behaviour_definition_old>
           TO <lv_created_by_old>.
    ASSERT sy-subrc = 0.

    ASSIGN COMPONENT 'METADATA-CREATED_AT' OF STRUCTURE <ls_behaviour_definition_old>
           TO <lv_created_at_old>.
    ASSERT sy-subrc = 0.

    <lv_created_at> = <lv_created_at_old>.
    <lv_created_by> = <lv_created_by_old>.

  ENDMETHOD.