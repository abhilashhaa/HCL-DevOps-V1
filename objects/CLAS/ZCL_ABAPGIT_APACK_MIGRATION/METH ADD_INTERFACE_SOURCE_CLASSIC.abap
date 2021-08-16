  METHOD add_interface_source_classic.
    DATA: lo_source      TYPE REF TO cl_oo_source,
          lt_source_code TYPE zif_abapgit_definitions=>ty_string_tt.

    CREATE OBJECT lo_source
      EXPORTING
        clskey             = is_clskey
      EXCEPTIONS
        class_not_existing = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from CL_OO_SOURCE' ).
    ENDIF.

    TRY.
        lo_source->access_permission( seok_access_modify ).
        lt_source_code = get_interface_source( ).
        lo_source->set_source( lt_source_code ).
        lo_source->save( ).
        lo_source->access_permission( seok_access_free ).
      CATCH cx_oo_access_permission.
        zcx_abapgit_exception=>raise( 'permission error' ).
      CATCH cx_oo_source_save_failure.
        zcx_abapgit_exception=>raise( 'save failure' ).
    ENDTRY.
  ENDMETHOD.