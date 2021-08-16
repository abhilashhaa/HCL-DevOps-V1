  METHOD export.

    DATA: li_log     TYPE REF TO zif_abapgit_log,
          lt_zip     TYPE zif_abapgit_definitions=>ty_files_item_tt,
          lv_package TYPE devclass.


    CREATE OBJECT li_log TYPE zcl_abapgit_log.

    lv_package = io_repo->get_package( ).

    IF zcl_abapgit_factory=>get_sap_package( lv_package )->exists( ) = abap_false.
      zcx_abapgit_exception=>raise( |Package { lv_package } doesn't exist| ).
    ENDIF.

    lt_zip = io_repo->get_files_local( ii_log    = li_log
                                       it_filter = it_filter ).

    IF li_log->count( ) > 0 AND iv_show_log = abap_true.
      zcl_abapgit_log_viewer=>show_log( iv_header_text = 'Zip Export Log'
                                        ii_log         = li_log ).
    ENDIF.

    rv_xstr = encode_files( lt_zip ).

  ENDMETHOD.