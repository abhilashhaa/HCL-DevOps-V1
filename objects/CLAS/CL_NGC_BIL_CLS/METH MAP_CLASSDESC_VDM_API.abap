  METHOD map_classdesc_vdm_api.

    TRY.
        IF is_classdesc_vdm IS SUPPLIED.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_desc
              is_source_vdm = is_classdesc_vdm
            CHANGING
              cs_target_api = rs_classdesc_api ).

          IF rs_classdesc_api-langu IS INITIAL.
            rs_classdesc_api-langu = sy-langu.
          ENDIF.

        ELSEIF is_classdesc_vdm_upd IS SUPPLIED.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_desc
              is_source_vdm  = is_classdesc_vdm_upd
              is_control_vdm = is_classdesc_vdm_upd-%control
              is_merge_api   = is_classdesc_new_api
            CHANGING
              cs_target_api  = rs_classdesc_api ).

          IF rs_classdesc_api-langu IS INITIAL.
            rs_classdesc_api-langu = sy-langu.
          ENDIF.
        ENDIF.
      CATCH cx_vdm_plmb_api_mapper ##NO_HANDLER.
        " TODO handle exception
    ENDTRY.

  ENDMETHOD.