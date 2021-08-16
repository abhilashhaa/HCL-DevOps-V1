  METHOD get_field_mapping.

    CASE iv_vdm_entity.
      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-characteristic.
        me->get_mapping_characteristic(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_desc.
        me->get_mapping_charcdesc(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_rstr.
        me->get_mapping_charcrstr(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_ref.
        me->get_mapping_charcref(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_val.
        me->get_mapping_charcval(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_chr_c=>gcs_vdm_entity_tp-charc_val_desc.
        me->get_mapping_charcval_desc(
          IMPORTING
            et_field_mapping = et_field_mapping ).
    ENDCASE.

  ENDMETHOD.