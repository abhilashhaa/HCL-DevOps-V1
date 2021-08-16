  METHOD prepare_gui_startup.

    DATA: lv_repo_key    TYPE zif_abapgit_persistence=>ty_value,
          lv_package     TYPE devclass,
          lv_package_adt TYPE devclass.

    check_sapgui( ).

    IF zcl_abapgit_persist_settings=>get_instance( )->read( )->get_show_default_repo( ) = abap_false.
      " Don't show the last seen repo at startup
      zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( || ).
    ENDIF.

    " We have three special cases for gui startup
    "   - open a specific repo by repo key
    "   - open a specific repo by package name
    "   - open a specific repo by package name provided by ADT
    " These overrule the last shown repo

    GET PARAMETER ID zif_abapgit_definitions=>c_spagpa_param_repo_key FIELD lv_repo_key.
    GET PARAMETER ID zif_abapgit_definitions=>c_spagpa_param_package  FIELD lv_package.
    lv_package_adt = get_package_from_adt( ).

    IF lv_repo_key IS NOT INITIAL.

      SET PARAMETER ID zif_abapgit_definitions=>c_spagpa_param_repo_key FIELD ''.
      zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( lv_repo_key ).

    ELSEIF lv_package IS NOT INITIAL.

      SET PARAMETER ID zif_abapgit_definitions=>c_spagpa_param_package FIELD ''.
      set_start_repo_from_package( lv_package ).

    ELSEIF lv_package_adt IS NOT INITIAL.

      set_start_repo_from_package( lv_package_adt ).

    ENDIF.

  ENDMETHOD.