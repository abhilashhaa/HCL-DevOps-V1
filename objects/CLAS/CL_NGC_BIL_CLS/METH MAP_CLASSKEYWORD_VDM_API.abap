  METHOD map_classkeyword_vdm_api.

    TRY.
        IF is_classkeyword_vdm IS SUPPLIED.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_keyword
              is_source_vdm = is_classkeyword_vdm
            CHANGING
              cs_target_api = rs_classkeyword_api ).

          IF rs_classkeyword_api-langu IS INITIAL.
            rs_classkeyword_api-langu = sy-langu.
          ENDIF.
        ELSEIF is_classkeyword_vdm_upd IS SUPPLIED.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_keyword
              is_source_vdm  = is_classkeyword_vdm_upd
              is_control_vdm = is_classkeyword_vdm_upd-%control
              is_merge_api   = is_classkeyword_new_api
            CHANGING
              cs_target_api  = rs_classkeyword_api ).

          IF rs_classkeyword_api-langu IS INITIAL.
            rs_classkeyword_api-langu = sy-langu.
          ENDIF.
        ENDIF.
      CATCH cx_vdm_plmb_api_mapper ##NO_HANDLER.
        " TODO: Report message
    ENDTRY.

  ENDMETHOD.