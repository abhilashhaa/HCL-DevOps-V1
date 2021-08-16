  METHOD attach_payload.

    DATA lo_type TYPE REF TO cl_abap_typedescr.
    lo_type = cl_abap_typedescr=>describe_by_data( iv_payload ).

    IF lo_type->type_kind = cl_abap_typedescr=>typekind_xstring.
      ii_request->set_data( iv_payload ).

    ELSEIF lo_type->type_kind = cl_abap_typedescr=>typekind_string.
      ii_request->set_cdata( iv_payload ).

    ELSE.
      zcx_abapgit_exception=>raise( |Unexpected payload type { lo_type->absolute_name }| ).
    ENDIF.

  ENDMETHOD.