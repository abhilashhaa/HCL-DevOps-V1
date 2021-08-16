  METHOD delete_text_with_class_d.

*--------------------------------------------------------------------*
* Arrangemets
*--------------------------------------------------------------------*

    mo_cut->mt_class_delete = VALUE #(
      ( %cid_ref = th_ngc_bil_cls_data=>cs_class_existing-cid classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

    mo_cut->mt_class_change = VALUE #(
      ( cid              = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid  = th_ngc_bil_cls_data=>cs_class-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class-class
        classtype        = th_ngc_bil_cls_data=>cs_class-classtype
        s_classbasic     = VALUE #(
          same_value_no = abap_true
          status        = th_ngc_bil_cls_data=>cs_class-classstatus )
        s_classbasic_new = VALUE #(
          same_value_e  = abap_true
          status        = th_ngc_bil_cls_data=>cs_class-classstatus )
        t_classtext      = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classtext_existing-language text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 text_type = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) )
        t_classtext_new  = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classtext_existing-language text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 text_type = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 fldelete = abap_true ) )
        t_operation_log  = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-delete_text ) ) ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_failed(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_reported(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls_transactional~check_before_save(
      IMPORTING
        et_class_text_failed   = DATA(lt_class_text_failed)
        et_class_text_reported = DATA(lt_class_text_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_text_failed
      exp = lt_failed_exp
      msg = 'Expected failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_text_reported
      exp = lt_reported_exp
      msg = 'Expected reported should be returned' ).

  ENDMETHOD.