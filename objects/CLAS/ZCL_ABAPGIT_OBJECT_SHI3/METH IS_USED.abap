  METHOD is_used.

    DATA: lt_used_in_structures TYPE STANDARD TABLE OF ttree WITH DEFAULT KEY.

    CALL FUNCTION 'STREE_GET_STRUCTURE_USAGE'
      EXPORTING
        structure_id       = iv_structure_id
      TABLES
        used_in_structures = lt_used_in_structures.

    IF lt_used_in_structures IS NOT INITIAL.
      zcx_abapgit_exception=>raise( |IMG structure ID { iv_structure_id } is still used| ).
    ENDIF.

  ENDMETHOD.