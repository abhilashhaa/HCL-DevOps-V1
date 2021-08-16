  METHOD run_syntax_check.

    DATA: li_syntax_check TYPE REF TO zif_abapgit_code_inspector.

    li_syntax_check = zcl_abapgit_factory=>get_code_inspector( mo_repo->get_package( ) ).
    mt_result = li_syntax_check->run( c_variant ).

  ENDMETHOD.