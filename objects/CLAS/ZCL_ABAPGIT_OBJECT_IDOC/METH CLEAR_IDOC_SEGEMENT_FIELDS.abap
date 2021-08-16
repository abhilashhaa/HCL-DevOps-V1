  METHOD clear_idoc_segement_fields.

    clear_idoc_segement_field( EXPORTING iv_fieldname = 'DEVC'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'PLAST'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'PWORK'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'PRESP'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'CREDATE'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'CRETIME'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'LDATE'
                               CHANGING  cg_structure = cg_structure ).
    clear_idoc_segement_field( EXPORTING iv_fieldname = 'LTIME'
                               CHANGING  cg_structure = cg_structure ).
  ENDMETHOD.