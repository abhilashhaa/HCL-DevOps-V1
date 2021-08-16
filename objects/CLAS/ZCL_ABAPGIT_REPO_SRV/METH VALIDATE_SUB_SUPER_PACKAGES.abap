  METHOD validate_sub_super_packages.

    DATA:
      ls_repo     LIKE LINE OF it_repos,
      li_package  TYPE REF TO zif_abapgit_sap_package,
      lt_packages TYPE zif_abapgit_sap_package=>ty_devclass_tt,
      lo_repo     TYPE REF TO zcl_abapgit_repo.

    LOOP AT it_repos INTO ls_repo.
      lo_repo = get( ls_repo-key ).

      li_package = zcl_abapgit_factory=>get_sap_package( ls_repo-package ).
      IF li_package->exists( ) = abap_false.
        " Skip dangling repository
        CONTINUE.
      ENDIF.

      CLEAR lt_packages.
      IF lo_repo->get_local_settings( )-ignore_subpackages = abap_false.
        APPEND LINES OF li_package->list_subpackages( ) TO lt_packages.
        READ TABLE lt_packages TRANSPORTING NO FIELDS
          WITH KEY table_line = iv_package.
        IF sy-subrc = 0.
          eo_repo = lo_repo.
          ev_reason = |Repository { lo_repo->get_name( ) } already contains { iv_package } |.
          RETURN.
        ENDIF.
      ENDIF.

      IF iv_ign_subpkg = abap_false.
        APPEND LINES OF li_package->list_superpackages( ) TO lt_packages.
        READ TABLE lt_packages TRANSPORTING NO FIELDS
          WITH KEY table_line = iv_package.
        IF sy-subrc = 0.
          eo_repo = lo_repo.
          ev_reason = |Repository { lo_repo->get_name( ) } already contains subpackage of { iv_package } |.
          RETURN.
        ENDIF.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.