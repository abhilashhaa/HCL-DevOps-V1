  METHOD jump_display_transport.

    DATA:
      lv_transport_adt_uri TYPE string,
      lv_adt_link          TYPE string,
      lv_adt_jump_enabled  TYPE abap_bool.

    lv_adt_jump_enabled = zcl_abapgit_persist_settings=>get_instance( )->read( )->get_adt_jump_enabled( ).
    IF lv_adt_jump_enabled = abap_true.
      TRY.
          CALL METHOD ('CL_CTS_ADT_TM_URI_BUILDER')=>('CREATE_ADT_URI')
            EXPORTING
              trnumber = iv_transport
            RECEIVING
              result   = lv_transport_adt_uri.
          lv_adt_link = |adt://{ sy-sysid }{ lv_transport_adt_uri }|.

          cl_gui_frontend_services=>execute( EXPORTING  document = lv_adt_link
                                             EXCEPTIONS OTHERS   = 1 ).
          IF sy-subrc <> 0.
            zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
          ENDIF.
        CATCH cx_root.
          CALL FUNCTION 'TR_DISPLAY_REQUEST'
            EXPORTING
              i_trkorr = iv_transport.
      ENDTRY.
    ELSE.
      CALL FUNCTION 'TR_DISPLAY_REQUEST'
        EXPORTING
          i_trkorr = iv_transport.
    ENDIF.

  ENDMETHOD.