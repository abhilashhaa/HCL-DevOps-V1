  METHOD delete_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_text) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_delete(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_classtext_new-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_new-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_new-longtextid ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_classtext_new-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_new-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_new-longtextid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_classtext_new-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_new-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_new-longtextid ) ).

    me->set_class( lt_class_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~delete_class_text(
      EXPORTING
        it_delete   = lt_class_text
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_failed
      exp = lt_failed_exp
      msg = 'Expected failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_reported
      exp = lt_reported_exp
      msg = 'Expected reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_class_change
      msg = 'Initial buffer expected' ).

  ENDMETHOD.