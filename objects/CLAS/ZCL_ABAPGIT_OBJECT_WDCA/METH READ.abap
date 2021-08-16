  METHOD read.

    DATA:
      lo_cfg    TYPE REF TO cl_wdr_cfg_persistence_appl,
      ls_key    TYPE wdy_config_key,
      lv_exists TYPE abap_bool,
      lx_err    TYPE REF TO cx_wd_configuration,
      lv_name   TYPE wdy_md_object_name.

    CLEAR: es_outline, et_data.

    ls_key = ms_item-obj_name.

    TRY.
        CREATE OBJECT lo_cfg
          EXPORTING
            config_key  = ls_key
            object_name = lv_name.

        MOVE-CORRESPONDING ls_key TO es_outline.

        lo_cfg->check_config_existent(
          EXPORTING
            i_outline_data       = es_outline
            i_only_current_layer = abap_false
            i_is_original        = abap_true
          IMPORTING
            e_is_existent        = lv_exists ).

        IF lv_exists = abap_false.
          RETURN.
        ENDIF.

        es_outline = lo_cfg->read_outline_data( ).

        CLEAR: es_outline-devclass,
               es_outline-author,
               es_outline-createdon,
               es_outline-changedby,
               es_outline-changedon.

        et_data = lo_cfg->read_data( ).

      CATCH cx_wd_configuration INTO lx_err.
        zcx_abapgit_exception=>raise( 'WDCA, read error:' && lx_err->get_text( ) ).
    ENDTRY.

  ENDMETHOD.