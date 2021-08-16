  METHOD get_field_mapping.

    CASE iv_vdm_entity.
      WHEN if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class.
        me->get_mapping_class(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_desc.
        me->get_mapping_classdesc(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_keyword.
        me->get_mapping_classkeyword(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_text.
        me->get_mapping_classtext(
          IMPORTING
            et_field_mapping = et_field_mapping ).

      WHEN if_ngc_bil_cls_c=>gcs_vdm_entity_tp-class_charc.
        me->get_mapping_classcharc(
          IMPORTING
            et_field_mapping = et_field_mapping ).
    ENDCASE.

  ENDMETHOD.