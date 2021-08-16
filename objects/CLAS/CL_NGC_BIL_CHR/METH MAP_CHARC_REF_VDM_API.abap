  METHOD map_charc_ref_vdm_api.

    TRY.
        mo_vdm_api_mapper->map_data_vdm_to_api(
          EXPORTING
            iv_vdm_entity = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_ref
            is_source_vdm = is_charc_ref_vdm
          CHANGING
            cs_target_api = rs_charc_ref_api ).

        TRANSLATE rs_charc_ref_api-reference_table TO UPPER CASE.
        TRANSLATE rs_charc_ref_api-reference_field TO UPPER CASE.

      CATCH cx_vdm_plmb_api_mapper.
        " TODO: Message
    ENDTRY.

  ENDMETHOD.