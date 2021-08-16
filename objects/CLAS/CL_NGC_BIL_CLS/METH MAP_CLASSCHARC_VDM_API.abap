  METHOD map_classcharc_vdm_api.

    TRY.
        IF is_classcharc_vdm IS SUPPLIED.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_charc
              is_source_vdm = is_classcharc_vdm
            CHANGING
              cs_target_api = rs_classcharc_api ).

          rs_classcharc_api-charcinternalid = COND #( WHEN is_classcharc_vdm-charcinternalid IS INITIAL
                                                      THEN me->get_charcinternalid( is_classcharc_vdm-characteristic )
                                                      ELSE is_classcharc_vdm-charcinternalid ).

          rs_classcharc_api-name_char = COND #( WHEN is_classcharc_vdm-characteristic IS INITIAL
                                                THEN me->get_characteristic( rs_classcharc_api-charcinternalid )
                                                ELSE is_classcharc_vdm-characteristic ).

        ELSEIF is_classcharc_vdm_upd IS SUPPLIED.

          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_charc
              is_source_vdm  = is_classcharc_vdm_upd
              is_control_vdm = is_classcharc_vdm_upd-%control
              is_merge_api   = is_classcharc_new_api
            CHANGING
              cs_target_api  =  rs_classcharc_api ).

          rs_classcharc_api-name_char = COND #( WHEN is_classcharc_new_api-name_char IS INITIAL
                                                THEN me->get_characteristic( rs_classcharc_api-charcinternalid )
                                                ELSE is_classcharc_new_api-name_char ).

        ENDIF.
      CATCH cx_vdm_plmb_api_mapper ##NO_HANDLER.
        " TODO: Report message
    ENDTRY.

  ENDMETHOD.