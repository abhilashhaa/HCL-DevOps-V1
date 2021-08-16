  METHOD clear_dynamic_fields.

    FIELD-SYMBOLS: <lg_header> TYPE any.


    ASSIGN COMPONENT 'HEADER' OF STRUCTURE cg_complete_comm_assembly
           TO <lg_header>.
    ASSERT sy-subrc = 0.

    clear_field(
      EXPORTING iv_fieldname = 'CREATEDBY'
      CHANGING  cg_header    = <lg_header> ).

    clear_field(
      EXPORTING iv_fieldname = 'CREATEDON'
      CHANGING  cg_header    = <lg_header> ).

    clear_field(
      EXPORTING iv_fieldname = 'CREATEDAT'
      CHANGING  cg_header    = <lg_header> ).

    clear_field(
      EXPORTING iv_fieldname = 'CHANGEDBY'
      CHANGING  cg_header    = <lg_header> ).

    clear_field(
      EXPORTING iv_fieldname = 'CHANGEDON'
      CHANGING  cg_header    = <lg_header> ).

    clear_field(
      EXPORTING iv_fieldname = 'CHANGEDAT'
      CHANGING  cg_header    = <lg_header> ).

  ENDMETHOD.