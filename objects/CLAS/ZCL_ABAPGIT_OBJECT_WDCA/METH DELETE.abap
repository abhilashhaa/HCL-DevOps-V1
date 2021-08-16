  METHOD delete.

    DATA:
      lo_cfg       TYPE REF TO cl_wdr_cfg_persistence_appl,
      lx_err       TYPE REF TO cx_wd_configuration,
      lt_messages  TYPE cts_messages,
      ls_key       TYPE wdy_config_key,
      ls_outline   TYPE wdy_cfg_outline_data,
      lv_operation TYPE i,
      lv_name      TYPE wdy_md_object_name,
      lv_exists    TYPE wdy_boolean,
      lv_transport TYPE trkorr.

    ls_key = ms_item-obj_name.

    TRY.
        CREATE OBJECT lo_cfg
          EXPORTING
            config_key  = ls_key
            object_name = lv_name.

        MOVE-CORRESPONDING ls_key TO ls_outline.

        lo_cfg->check_config_existent(
          EXPORTING
            i_outline_data       = ls_outline
            i_only_current_layer = abap_false
            i_is_original        = abap_true
          IMPORTING
            e_is_existent        = lv_exists ).

        IF lv_exists = abap_false.
          RETURN.
        ENDIF.

        lv_transport = zcl_abapgit_default_transport=>get_instance( )->get( )-ordernum.
        lo_cfg->set_transport( trkorr   = lv_transport
                               devclass = iv_package ).

        lv_operation = if_wdr_cfg_constants=>c_cts_operation-e_delete.
        " First call, check, second call, delete
        DO 2 TIMES.
          lo_cfg->do_next_step(
            IMPORTING
              e_messages = lt_messages
            CHANGING
              c_operation = lv_operation ).
          check( lt_messages ).
        ENDDO.

      CATCH cx_wd_configuration INTO lx_err.
        IF lx_err->textid = cx_wd_configuration=>conf_config_not_exist.
          RETURN.
        ELSE.
          zcx_abapgit_exception=>raise( 'WDCA, delete error:' && lx_err->get_text( ) ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.