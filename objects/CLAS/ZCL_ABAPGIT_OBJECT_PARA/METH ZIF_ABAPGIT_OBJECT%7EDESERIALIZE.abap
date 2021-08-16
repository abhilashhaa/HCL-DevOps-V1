  METHOD zif_abapgit_object~deserialize.
* see fm RS_PARAMETER_ADD and RS_PARAMETER_EDIT

    DATA: lv_mode   TYPE c LENGTH 1,
          ls_tpara  TYPE tpara,
          ls_tparat TYPE tparat.


    SELECT SINGLE * FROM tpara INTO ls_tpara
      WHERE paramid = ms_item-obj_name.                 "#EC CI_GENBUFF
    IF sy-subrc = 0.
      lv_mode = 'M'.
    ELSE.
      lv_mode = 'I'.
    ENDIF.

    io_xml->read( EXPORTING iv_name = 'TPARA'
                  CHANGING cg_data = ls_tpara ).
    io_xml->read( EXPORTING iv_name = 'TPARAT'
                  CHANGING cg_data = ls_tparat ).

    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        object              = ms_item-obj_name
        object_class        = 'PARA'
        mode                = lv_mode
        global_lock         = abap_true
        devclass            = iv_package
        master_language     = mv_language
        suppress_dialog     = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from RS_CORR_INSERT, PARA' ).
    ENDIF.

    MODIFY tpara FROM ls_tpara.                           "#EC CI_SUBRC
    ASSERT sy-subrc = 0.

    MODIFY tparat FROM ls_tparat.                         "#EC CI_SUBRC
    ASSERT sy-subrc = 0.

  ENDMETHOD.