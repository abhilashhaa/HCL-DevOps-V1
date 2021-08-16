  METHOD zip.

    DATA: lt_requests TYPE trwbo_requests,
          lt_tadir    TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lv_package  TYPE devclass,
          ls_data     TYPE zif_abapgit_persistence=>ty_repo,
          lo_repo     TYPE REF TO zcl_abapgit_repo_offline,
          lt_trkorr   TYPE trwbo_request_headers.


    IF is_trkorr IS SUPPLIED.
      APPEND is_trkorr TO lt_trkorr.
    ELSE.
      lt_trkorr = zcl_abapgit_ui_factory=>get_popups( )->popup_to_select_transports( ).
    ENDIF.

    IF lines( lt_trkorr ) = 0.
      RETURN.
    ENDIF.

    lt_requests = read_requests( lt_trkorr ).
    lt_tadir = resolve( lt_requests ).
    IF lines( lt_tadir ) = 0.
      zcx_abapgit_exception=>raise( 'empty transport' ).
    ENDIF.

    lv_package = find_top_package( lt_tadir ).
    IF lv_package IS INITIAL.
      zcx_abapgit_exception=>raise( 'error finding super package' ).
    ENDIF.

    ls_data-key         = 'TZIP'.
    ls_data-package     = lv_package.
    ls_data-dot_abapgit = zcl_abapgit_dot_abapgit=>build_default( )->get_data( ).

    IF iv_logic IS SUPPLIED AND iv_logic IS NOT INITIAL.
      ls_data-dot_abapgit-folder_logic = iv_logic.
    ELSE.
      ls_data-dot_abapgit-folder_logic = zcl_abapgit_ui_factory=>get_popups( )->popup_folder_logic( ).
    ENDIF.

    CREATE OBJECT lo_repo
      EXPORTING
        is_data = ls_data.

    rv_xstr = zcl_abapgit_zip=>export(
      io_repo     = lo_repo
      it_filter   = lt_tadir
      iv_show_log = iv_show_log_popup ).

  ENDMETHOD.