  METHOD has_manifest.

    DATA: ls_returned_manifest TYPE zif_abapgit_apack_definitions=>ty_descriptor.

    ls_returned_manifest = get_manifest_descriptor( ).

    rv_has_manifest = abap_false.
    IF ls_returned_manifest IS NOT INITIAL.
      rv_has_manifest = abap_true.
    ENDIF.

  ENDMETHOD.