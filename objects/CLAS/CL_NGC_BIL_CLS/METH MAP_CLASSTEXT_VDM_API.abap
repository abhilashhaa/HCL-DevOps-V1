  METHOD map_classtext_vdm_api.
    TRY.
        IF is_classtext_vdm IS SUPPLIED.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_text
              is_source_vdm = is_classtext_vdm
            CHANGING
              cs_target_api = rs_classtext_api ).
          " The handling of this field by the BAPI is different from the VDM,
          " therefore we need this kind of mapping
          rs_classtext_api-text_type = is_classtext_vdm-longtextid+2.
        ELSEIF is_classtext_vdm_upd IS SUPPLIED.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_text
              is_source_vdm  = is_classtext_vdm_upd
              is_control_vdm = is_classtext_vdm_upd-%control
              is_merge_api   = is_classtext_api
            CHANGING
              cs_target_api  = rs_classtext_api ).

        ENDIF.

        IF rs_classtext_api-langu IS INITIAL.
          rs_classtext_api-langu = sy-langu.
        ENDIF.
      CATCH cx_vdm_plmb_api_mapper ##NO_HANDLER.
        " TODO: Report message
    ENDTRY.
  ENDMETHOD.