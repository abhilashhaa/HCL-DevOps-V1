  METHOD zif_abapgit_repo_srv~validate_package.

    DATA: lv_as4user TYPE tdevc-as4user,
          lo_repo    TYPE REF TO zcl_abapgit_repo,
          lv_reason  TYPE string.

    IF iv_package IS INITIAL.
      zcx_abapgit_exception=>raise( 'add, package empty' ).
    ENDIF.

    IF iv_package = '$TMP'.
      zcx_abapgit_exception=>raise( 'not possible to use $TMP, create new (local) package' ).
    ENDIF.

    SELECT SINGLE as4user FROM tdevc
      INTO lv_as4user
      WHERE devclass = iv_package.                      "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Package { iv_package } not found| ).
    ENDIF.

    IF is_sap_object_allowed( ) = abap_false AND lv_as4user = 'SAP'.
      zcx_abapgit_exception=>raise( |Package { iv_package } not allowed, responsible user = 'SAP'| ).
    ENDIF.

    IF iv_chk_exists = abap_true.
      get_repo_from_package(
        EXPORTING
          iv_package = iv_package
          iv_ign_subpkg = iv_ign_subpkg
        IMPORTING
          eo_repo    = lo_repo
          ev_reason  = lv_reason ).

      IF lo_repo IS BOUND.
        zcx_abapgit_exception=>raise( lv_reason ).
      ENDIF.
    ENDIF.

  ENDMETHOD.