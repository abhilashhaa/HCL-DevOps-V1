  METHOD if_ngc_core_cls_persistency~cleanup.

    CLEAR:
      mt_klah_data,
      mt_characteristic_data,
      mt_class_status,
      mt_clfnclasshiercharc,
      mt_clfnclasshiercharcforkeydat,
      mt_clfncharcvalueforkeydate,
      mt_clfnobjectcharcvalue,
      mt_org_area_w_disp_auth,
      mt_org_area_w_auth,
      mt_classtype,
      mt_parent_objectclassbasic,
      mt_buffered_data.

    mo_chr_persistency = cl_ngc_core_factory=>get_chr_persistency( ).

  ENDMETHOD.