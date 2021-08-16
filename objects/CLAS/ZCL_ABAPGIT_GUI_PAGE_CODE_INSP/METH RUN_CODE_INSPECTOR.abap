  METHOD run_code_inspector.

    DATA: li_code_inspector TYPE REF TO zif_abapgit_code_inspector.

    li_code_inspector = zcl_abapgit_factory=>get_code_inspector( mo_repo->get_package( ) ).

    mt_result = li_code_inspector->run(
      iv_variant = |{ mv_check_variant }|
      iv_save    = abap_true ).

    DELETE mt_result WHERE kind = 'N'.

  ENDMETHOD.