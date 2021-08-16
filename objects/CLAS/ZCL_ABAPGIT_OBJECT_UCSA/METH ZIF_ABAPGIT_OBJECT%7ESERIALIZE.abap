  METHOD zif_abapgit_object~serialize.

    DATA: lv_id                     TYPE ty_id,
          lx_root                   TYPE REF TO cx_root,
          lv_text                   TYPE string,
          lo_persistence            TYPE REF TO object,
          lr_complete_comm_assembly TYPE REF TO data.

    FIELD-SYMBOLS: <lg_complete_comm_assembly> TYPE any.


    lv_id = ms_item-obj_name.

    TRY.
        CREATE DATA lr_complete_comm_assembly TYPE ('UCONSERVASCOMPLETE').
        ASSIGN lr_complete_comm_assembly->* TO <lg_complete_comm_assembly>.
        ASSERT sy-subrc = 0.

        lo_persistence = get_persistence( lv_id ).

        CALL METHOD lo_persistence->('IF_UCON_SA_PERSIST~LOAD')
          EXPORTING
            version  = c_version-active
            language = mv_language
          IMPORTING
            sa       = <lg_complete_comm_assembly>.

        clear_dynamic_fields( CHANGING cg_complete_comm_assembly = <lg_complete_comm_assembly> ).

        io_xml->add( iv_name = 'UCSA'
                     ig_data = <lg_complete_comm_assembly> ).

      CATCH cx_root INTO lx_root.
        lv_text = lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.