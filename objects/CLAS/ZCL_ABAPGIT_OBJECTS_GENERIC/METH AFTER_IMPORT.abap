  METHOD after_import.

    DATA: lt_cts_object_entry TYPE STANDARD TABLE OF e071 WITH DEFAULT KEY,
          ls_cts_object_entry LIKE LINE OF lt_cts_object_entry,
          lt_cts_key          TYPE STANDARD TABLE OF e071k WITH DEFAULT KEY.

    FIELD-SYMBOLS <ls_object_method> LIKE LINE OF mt_object_method.


    ls_cts_object_entry-pgmid    = seok_pgmid_r3tr.
    ls_cts_object_entry-object   = ms_item-obj_type.
    ls_cts_object_entry-obj_name = ms_item-obj_name.
    INSERT ls_cts_object_entry INTO TABLE lt_cts_object_entry.

    READ TABLE mt_object_method ASSIGNING <ls_object_method>
      WITH KEY
        objectname = ms_item-obj_type
        objecttype = 'L'
        method = 'AFTER_IMP'.
    IF sy-subrc = 0.
* client is actually optional for most AIM, but let's supply it and hope
* that those client-independent-ones just ignore it
      CALL FUNCTION <ls_object_method>-methodname
        EXPORTING
          iv_tarclient  = sy-mandt
          iv_is_upgrade = abap_false
        TABLES
          tt_e071       = lt_cts_object_entry
          tt_e071k      = lt_cts_key.
    ENDIF.

  ENDMETHOD.