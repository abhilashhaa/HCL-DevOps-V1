  METHOD zif_abapgit_object~serialize.

    DATA: lr_template TYPE REF TO data.
    FIELD-SYMBOLS: <lg_template> TYPE any.

    TRY.
        CREATE DATA lr_template TYPE ('IF_CMP_TEMPLATE_DB=>TYP_TEMPLATE').
        ASSIGN lr_template->* TO <lg_template>.

        CALL METHOD mo_cmp_db->('IF_CMP_TEMPLATE_DB~READ_TEMPLATE')
          EXPORTING
            i_name     = |{ ms_item-obj_name }|
            i_version  = 'A'
          RECEIVING
            r_template = <lg_template>.

        io_xml->add( iv_name = 'CMPT'
                     ig_data = <lg_template> ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'CMPT not supported' ).
    ENDTRY.

  ENDMETHOD.