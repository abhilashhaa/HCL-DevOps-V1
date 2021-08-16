  METHOD zif_abapgit_object~delete.

    DATA: lv_deleted TYPE abap_bool.

    TRY.
        CALL METHOD mo_cmp_db->('IF_CMP_TEMPLATE_DB~DELETE_TEMPLATE')
          EXPORTING
            i_name        = mv_name
            i_version     = 'A'
            i_flg_header  = abap_true
            i_flg_lines   = abap_true
          RECEIVING
            r_flg_deleted = lv_deleted.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'CMPT not supported' ).
    ENDTRY.

    IF lv_deleted = abap_false.
      zcx_abapgit_exception=>raise( |Error deleting CMPT { ms_item-obj_name }| ).
    ENDIF.

  ENDMETHOD.