  METHOD zif_abapgit_object~deserialize.

    DATA: lv_id                     TYPE ty_id,
          lx_root                   TYPE REF TO cx_root,
          lv_text                   TYPE string,
          lo_persistence            TYPE REF TO object,
          lr_complete_comm_assembly TYPE REF TO data.

    FIELD-SYMBOLS: <lg_complete_comm_assembly> TYPE any.

    TRY.
        CREATE DATA lr_complete_comm_assembly TYPE ('UCONSERVASCOMPLETE').
        ASSIGN lr_complete_comm_assembly->* TO <lg_complete_comm_assembly>.
        ASSERT sy-subrc = 0.

        io_xml->read(
          EXPORTING
            iv_name = 'UCSA'
          CHANGING
            cg_data = <lg_complete_comm_assembly> ).

        lv_id = ms_item-obj_name.

        lo_persistence = get_persistence( lv_id ).

        CALL METHOD lo_persistence->('IF_UCON_SA_PERSIST~CREATE').

        CALL METHOD lo_persistence->('IF_UCON_SA_PERSIST~SAVE')
          EXPORTING
            sa      = <lg_complete_comm_assembly>
            version = c_version-active.

        tadir_insert( iv_package ).

      CATCH cx_root INTO lx_root.
        lv_text = lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.