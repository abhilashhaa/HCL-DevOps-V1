  METHOD set_start_repo_from_package.

    DATA: lo_repo          TYPE REF TO zcl_abapgit_repo,
          lt_r_package     TYPE RANGE OF devclass,
          ls_r_package     LIKE LINE OF lt_r_package,
          lt_superpackages TYPE zif_abapgit_sap_package=>ty_devclass_tt,
          li_package       TYPE REF TO zif_abapgit_sap_package,
          lt_repo_list     TYPE zif_abapgit_definitions=>ty_repo_ref_tt.

    FIELD-SYMBOLS: <lo_repo>         TYPE LINE OF zif_abapgit_definitions=>ty_repo_ref_tt,
                   <lv_superpackage> LIKE LINE OF lt_superpackages.

    li_package = zcl_abapgit_factory=>get_sap_package( iv_package ).

    IF li_package->exists( ) = abap_false.
      RETURN.
    ENDIF.

    ls_r_package-sign   = 'I'.
    ls_r_package-option = 'EQ'.
    ls_r_package-low    = iv_package.
    INSERT ls_r_package INTO TABLE lt_r_package.

    " Also consider superpackages. E.g. when some open $abapgit_ui, abapGit repo
    " should be found via package $abapgit
    lt_superpackages = li_package->list_superpackages( ).
    LOOP AT lt_superpackages ASSIGNING <lv_superpackage>.
      ls_r_package-low = <lv_superpackage>.
      INSERT ls_r_package INTO TABLE lt_r_package.
    ENDLOOP.

    lt_repo_list = zcl_abapgit_repo_srv=>get_instance( )->list( ).

    LOOP AT lt_repo_list ASSIGNING <lo_repo>.

      IF <lo_repo>->get_package( ) IN lt_r_package.
        lo_repo = <lo_repo>.
        EXIT.
      ENDIF.

    ENDLOOP.

    IF lo_repo IS BOUND.
      zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( lo_repo->get_key( ) ).
    ENDIF.

  ENDMETHOD.