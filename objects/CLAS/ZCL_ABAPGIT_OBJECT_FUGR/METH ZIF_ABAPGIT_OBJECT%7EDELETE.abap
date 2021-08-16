  METHOD zif_abapgit_object~delete.

    DATA: lv_area     TYPE rs38l-area,
          lt_includes TYPE ty_sobj_name_tt,
          lv_corrnum  TYPE e070use-ordernum.


    lt_includes = includes( ).

    lv_area = ms_item-obj_name.
    lv_corrnum = zcl_abapgit_default_transport=>get_instance( )->get( )-ordernum.

    CALL FUNCTION 'RS_FUNCTION_POOL_DELETE'
      EXPORTING
        area                   = lv_area
        suppress_popups        = abap_true
        skip_progress_ind      = abap_true
        corrnum                = lv_corrnum
      EXCEPTIONS
        canceled_in_corr       = 1
        enqueue_system_failure = 2
        function_exist         = 3
        not_executed           = 4
        no_modify_permission   = 5
        no_show_permission     = 6
        permission_failure     = 7
        pool_not_exist         = 8
        cancelled              = 9
        OTHERS                 = 10.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from RS_FUNCTION_POOL_DELETE' ).
    ENDIF.

    update_where_used( lt_includes ).

  ENDMETHOD.