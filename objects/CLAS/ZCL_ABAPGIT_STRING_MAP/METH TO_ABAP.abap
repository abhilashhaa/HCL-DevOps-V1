  METHOD to_abap.

    DATA lo_type TYPE REF TO cl_abap_typedescr.
    DATA lo_struc TYPE REF TO cl_abap_structdescr.
    DATA lv_field TYPE string.
    FIELD-SYMBOLS <ls_entry> LIKE LINE OF mt_entries.
    FIELD-SYMBOLS <lv_val> TYPE any.

    lo_type = cl_abap_typedescr=>describe_by_data( cs_container ).
    IF lo_type->type_kind <> cl_abap_typedescr=>typekind_struct1
      AND lo_type->type_kind <> cl_abap_typedescr=>typekind_struct2.
      zcx_abapgit_exception=>raise( 'Only structures supported' ).
    ENDIF.

    lo_struc ?= lo_type.
    LOOP AT mt_entries ASSIGNING <ls_entry>.
      lv_field = to_upper( <ls_entry>-k ).
      ASSIGN COMPONENT lv_field OF STRUCTURE cs_container TO <lv_val>.
      IF sy-subrc = 0.
        " TODO check target type ?
        <lv_val> = <ls_entry>-v.
      ELSE.
        zcx_abapgit_exception=>raise( |Component { lv_field } not found in target| ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.