  METHOD is_active.

    DATA: lt_messages    TYPE STANDARD TABLE OF sprot_u WITH DEFAULT KEY,
          lt_e071_tadirs TYPE STANDARD TABLE OF e071 WITH DEFAULT KEY,
          ls_e071_tadir  LIKE LINE OF lt_e071_tadirs.

    ms_item-inactive = abap_false.

    ls_e071_tadir-object   = ms_item-obj_type.
    ls_e071_tadir-obj_name = ms_item-obj_name.
    INSERT ls_e071_tadir INTO TABLE lt_e071_tadirs.

    CALL FUNCTION 'RS_INACTIVE_OBJECTS_WARNING'
      EXPORTING
        suppress_protocol         = abap_false
        with_program_includes     = abap_false
        suppress_dictionary_check = abap_false
      TABLES
        p_e071                    = lt_e071_tadirs
        p_xmsg                    = lt_messages.

    IF lt_messages IS NOT INITIAL.
      ms_item-inactive = abap_true.
    ENDIF.

    rv_active = boolc( ms_item-inactive = abap_false ).
  ENDMETHOD.