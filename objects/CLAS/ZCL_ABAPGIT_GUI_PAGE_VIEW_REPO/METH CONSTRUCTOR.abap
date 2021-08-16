  METHOD constructor.

    DATA: lo_settings TYPE REF TO zcl_abapgit_settings,
          lv_package  TYPE devclass.

    super->constructor( ).

    mv_key           = iv_key.
    mo_repo          = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    mv_cur_dir       = '/'. " Root
    mv_hide_files    = zcl_abapgit_persistence_user=>get_instance( )->get_hide_files( ).
    mv_changes_only  = zcl_abapgit_persistence_user=>get_instance( )->get_changes_only( ).
    mv_diff_first    = abap_true.

    ms_control-page_title = 'Repository'.
    ms_control-page_menu = build_main_menu( ).

    " Read global settings to get max # of objects to be listed
    lo_settings     = zcl_abapgit_persist_settings=>get_instance( )->read( ).
    mv_max_lines    = lo_settings->get_max_lines( ).
    mv_max_setting  = mv_max_lines.

    lv_package = mo_repo->get_package( ).

    mv_are_changes_recorded_in_tr = zcl_abapgit_factory=>get_sap_package( lv_package
      )->are_changes_recorded_in_tr_req( ).

  ENDMETHOD.