  METHOD map_charc_desc_vdm_api.

    TRY.
        mo_vdm_api_mapper->map_data_vdm_to_api(
          EXPORTING
            iv_vdm_entity = if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_desc
            is_source_vdm = is_charc_desc_vdm
          CHANGING
            cs_target_api = rs_charc_desc_api ).

        rs_charc_desc_api-language_int = COND #( WHEN is_charc_desc_vdm-language IS INITIAL THEN sy-langu ELSE is_charc_desc_vdm-language ).

      CATCH cx_vdm_plmb_api_mapper.
        " TODO: Message
    ENDTRY.

  ENDMETHOD.