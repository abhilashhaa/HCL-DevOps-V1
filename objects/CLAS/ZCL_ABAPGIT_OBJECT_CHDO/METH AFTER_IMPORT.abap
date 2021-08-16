  METHOD after_import.

    DATA: lt_cts_object_entry TYPE STANDARD TABLE OF e071 WITH DEFAULT KEY,
          ls_cts_object_entry LIKE LINE OF lt_cts_object_entry,
          lt_errormsg         TYPE STANDARD TABLE OF sprot_u WITH DEFAULT KEY.

    ls_cts_object_entry-pgmid    = seok_pgmid_r3tr.
    ls_cts_object_entry-object   = ms_item-obj_type.
    ls_cts_object_entry-obj_name = ms_item-obj_name.
    INSERT ls_cts_object_entry INTO TABLE lt_cts_object_entry.

    CALL FUNCTION 'AFTER_IMP_CHDO'
      EXPORTING
        iv_tarclient  = sy-mandt
        iv_is_upgrade = abap_false
      TABLES
        tt_e071       = lt_cts_object_entry
        tt_errormsg   = lt_errormsg.

    LOOP AT lt_errormsg TRANSPORTING NO FIELDS WHERE severity = 'E' OR severity = 'A'.
      EXIT.
    ENDLOOP.

    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( 'Error from AFTER_IMP_CHDO' ).
    ENDIF.

  ENDMETHOD.