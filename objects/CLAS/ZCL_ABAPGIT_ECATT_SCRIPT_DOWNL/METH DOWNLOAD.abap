  METHOD download.

    " Downport

    load_help = im_load_help.
    typ = im_object_type.

    TRY.
        cl_apl_ecatt_object=>show_object(
          EXPORTING
            im_obj_type = im_object_type
            im_name     = im_object_name
            im_version  = im_object_version
          IMPORTING
            re_object   = ecatt_object ).
      CATCH cx_ecatt INTO ex_ecatt.
        RETURN.
    ENDTRY.

    toolname = ecatt_object->attrib->get_tool_name( ).
    set_attributes_to_template( ).

    IF toolname = cl_apl_ecatt_const=>toolname_ecatt.

      ecatt_script ?= ecatt_object.

      set_script_to_template( ).

      TRY.
          get_general_params_data( ecatt_script->params ).
        CATCH cx_ecatt_apl.                              "#EC NO_HANDLER
*         proceed with download and report errors later
      ENDTRY.

      LOOP AT parm INTO wa_parm.
        TRY.
            IF wa_parm-value = '<INITIAL>'.
              CLEAR wa_parm-value.
            ENDIF.
            set_general_params_data_to_dom( ).
            IF NOT wa_parm-pstruc_typ IS INITIAL.
              set_deep_stru_to_dom( ecatt_script->params ).
              set_deep_data_to_dom( ecatt_script->params ).
              IF wa_parm-xmlref_typ = cl_apl_ecatt_const=>ref_type_c_tcd.
                set_control_data_for_tcd( is_param  = wa_parm
                                          io_params = ecatt_script->params ).

              ENDIF.
            ENDIF.
          CATCH cx_ecatt_apl.                            "#EC NO_HANDLER
*         proceed with download and report errors later
        ENDTRY.
      ENDLOOP.

    ELSE.

      set_blob_to_template( ).
      set_artmp_to_template( ).

    ENDIF.

    download_data( ).

  ENDMETHOD.