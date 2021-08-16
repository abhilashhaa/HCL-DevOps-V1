  METHOD map_charc_vdm_api.

    TRY.
        IF is_charc_vdm IS NOT INITIAL.
          mo_vdm_api_mapper->map_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-characteristic
              is_source_vdm = is_charc_vdm
            CHANGING
              cs_target_api = rs_charc_api ).

          rs_charc_api-value_assignment = COND #( WHEN is_charc_vdm-multiplevaluesareallowed = abap_true THEN 'M' ELSE 'S' ).
        ELSEIF is_charc_vdm_upd IS NOT INITIAL AND is_charc_api IS NOT INITIAL.
          mo_vdm_api_mapper->map_and_merge_data_vdm_to_api(
            EXPORTING
              iv_vdm_entity  = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-characteristic
              is_source_vdm  = is_charc_vdm_upd
              is_control_vdm = is_charc_vdm_upd-%control
              is_merge_api   = is_charc_api
            CHANGING
              cs_target_api  = rs_charc_api ).

          IF is_charc_vdm_upd-%control-multiplevaluesareallowed = cl_abap_behavior_handler=>flag_changed.
            rs_charc_api-value_assignment = COND #( WHEN is_charc_vdm_upd-multiplevaluesareallowed = abap_true THEN 'M' ELSE 'S' ).
          ENDIF.
        ENDIF.

        rs_charc_api-unit_of_measurement_iso = rs_charc_api-unit_of_measurement.
        rs_charc_api-currency_iso            = rs_charc_api-currency.
        rs_charc_api-template_long           = rs_charc_api-template.

        IF is_charc_vdm-charcdatatype = if_ngc_c=>gc_charcdatatype-curr.
          rs_charc_api-decimals = mo_ngc_db_access->read_currency_decimals( rs_charc_api-currency ).
        ENDIF.

      CATCH cx_vdm_plmb_api_mapper.
        " TODO: Report message
    ENDTRY.

  ENDMETHOD.