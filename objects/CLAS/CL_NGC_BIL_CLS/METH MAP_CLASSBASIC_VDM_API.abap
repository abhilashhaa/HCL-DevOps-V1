  METHOD map_classbasic_vdm_api.

    TRY.
        IF is_class_vdm IS SUPPLIED.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class
              is_source_vdm = is_class_vdm
            CHANGING
              cs_target_api = rs_classbasic_api ).

          CASE is_class_vdm-sameclassfctnreaction.
            WHEN 'E'.
              rs_classbasic_api-same_value_e  = abap_true.
            WHEN 'W'.
              rs_classbasic_api-same_value_w  = abap_true.
            WHEN ' '.
              rs_classbasic_api-same_value_no = abap_true.
          ENDCASE.
        ELSEIF is_class_vdm_upd IS SUPPLIED AND is_classbasic_new_api IS SUPPLIED.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity   = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class
              is_source_vdm   = is_class_vdm_upd
              is_control_vdm  = is_class_vdm_upd-%control
              is_merge_api    = is_classbasic_new_api
            CHANGING
              cs_target_api   = rs_classbasic_api ).

          IF is_class_vdm_upd-%control-sameclassfctnreaction = cl_abap_behavior_handler=>flag_changed.
            CASE is_class_vdm_upd-sameclassfctnreaction.
              WHEN 'E'.
                rs_classbasic_api-same_value_e  = abap_true.
                CLEAR: rs_classbasic_api-same_value_w,
                       rs_classbasic_api-same_value_no.
              WHEN 'W'.
                rs_classbasic_api-same_value_w  = abap_true.
                CLEAR: rs_classbasic_api-same_value_e,
                       rs_classbasic_api-same_value_no.
              WHEN ' '.
                rs_classbasic_api-same_value_no = abap_true.
                CLEAR: rs_classbasic_api-same_value_e,
                       rs_classbasic_api-same_value_w.
            ENDCASE.
          ENDIF.
        ENDIF.
      CATCH cx_vdm_plmb_api_mapper ##NO_HANDLER.
        " TODO handle exception
    ENDTRY.

  ENDMETHOD.