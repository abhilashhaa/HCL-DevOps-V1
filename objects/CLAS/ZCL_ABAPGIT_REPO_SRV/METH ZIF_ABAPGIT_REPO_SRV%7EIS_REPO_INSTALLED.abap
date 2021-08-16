  METHOD zif_abapgit_repo_srv~is_repo_installed.

    DATA: lt_repo        TYPE zif_abapgit_definitions=>ty_repo_ref_tt,
          lo_repo        TYPE REF TO zcl_abapgit_repo,
          lv_url         TYPE string,
          lv_package     TYPE devclass,
          lo_repo_online TYPE REF TO zcl_abapgit_repo_online,
          lv_err         TYPE string.

    lt_repo = list( ).

    LOOP AT lt_repo INTO lo_repo.
      CHECK lo_repo->is_offline( ) = abap_false.
      lo_repo_online ?= lo_repo.

      lv_url     = lo_repo_online->get_url( ).
      lv_package = lo_repo_online->get_package( ).
      CHECK to_upper( lv_url ) = to_upper( iv_url ).

      " Validate bindings
      "TODO refactor: move this message out of this method
      IF iv_target_package IS NOT INITIAL AND iv_target_package <> lv_package.
        lv_err = |Installation to package { lv_package } detected. |
              && |Cancelling installation|.
        zcx_abapgit_exception=>raise( lv_err ).
      ENDIF.

      rv_installed = abap_true.
      EXIT.
    ENDLOOP.

  ENDMETHOD.