  METHOD map_charc_val_vdm_api.

    TRY.
        IF is_charc_val_vdm IS NOT INITIAL.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_val
              is_source_vdm = is_charc_val_vdm
            CHANGING
              cs_target_api = rs_charc_val_api ).
        ELSEIF is_charc_val_vdm_upd IS NOT INITIAL AND is_charc_val_api IS NOT INITIAL.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_val
              is_source_vdm  = is_charc_val_vdm_upd
              is_control_vdm = is_charc_val_vdm_upd-%control
              is_merge_api   = is_charc_val_api
            CHANGING
              cs_target_api  = rs_charc_val_api ).
        ENDIF.

        CASE rs_charc_val_api-value_relation.
          WHEN gs_charcvaldependency-eq OR
               gs_charcvaldependency-lt OR
               gs_charcvaldependency-le OR
               gs_charcvaldependency-gt OR
               gs_charcvaldependency-ge.
            CLEAR:
              rs_charc_val_api-value_to,
              rs_charc_val_api-currency_to, rs_charc_val_api-currency_to_iso,
              rs_charc_val_api-unit_to, rs_charc_val_api-unit_to_iso.
        ENDCASE.

        rs_charc_val_api-value_relation = COND #( WHEN rs_charc_val_api-value_relation IS INITIAL THEN gs_charcvaldependency-eq ELSE rs_charc_val_api-value_relation ).

        IF is_charc_api IS NOT INITIAL AND is_charc_api-case_sensitiv = abap_false.
          TRANSLATE rs_charc_val_api-value_char TO UPPER CASE.
        ENDIF.

      CATCH cx_vdm_plmb_api_mapper.
        " TODO: Message
    ENDTRY.

  ENDMETHOD.