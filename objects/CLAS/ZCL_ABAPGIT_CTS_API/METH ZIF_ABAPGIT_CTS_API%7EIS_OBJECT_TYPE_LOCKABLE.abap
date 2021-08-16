  METHOD zif_abapgit_cts_api~is_object_type_lockable.
    DATA: ls_object_key        TYPE e071,
          lv_type_check_result TYPE c LENGTH 1.

    ls_object_key-pgmid = iv_program_id.
    ls_object_key-object = iv_object_type.
    ls_object_key-obj_name = '_'. " Dummy value #2071

    CALL FUNCTION 'TR_CHECK_TYPE'
      EXPORTING
        wi_e071   = ls_object_key
      IMPORTING
        pe_result = lv_type_check_result.

    rv_lockable = boolc( lv_type_check_result = 'L' ).
  ENDMETHOD.