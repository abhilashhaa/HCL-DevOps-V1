  METHOD map_classdocument_vdm_api ##NEEDED.
*--------------------------------------------------------------------*
* This method is not used currently, therefore it's commented out.
*--------------------------------------------------------------------*
*    TRY.
*        mo_vdm_api_mapper->map_data_vdm_to_api(
*          EXPORTING
*            iv_vdm_entity = if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class
*            is_source_vdm = is_class_vdm
*          CHANGING
*            cs_target_api = rs_classdocument_api ).
*      CATCH cx_vdm_plmb_api_mapper.
*        " TODO: Report message
*    ENDTRY.
  ENDMETHOD.