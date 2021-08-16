  METHOD zif_abapgit_object~delete.

    DATA: lv_id          TYPE ty_id,
          lx_root        TYPE REF TO cx_root,
          lv_text        TYPE string,
          lo_persistence TYPE REF TO object.

    TRY.
        lv_id = ms_item-obj_name.

        lo_persistence = get_persistence( lv_id ).

        CALL METHOD lo_persistence->('IF_UCON_SA_PERSIST~DELETE')
          EXPORTING
            version = c_version-active.

      CATCH cx_root INTO lx_root.
        lv_text = lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.