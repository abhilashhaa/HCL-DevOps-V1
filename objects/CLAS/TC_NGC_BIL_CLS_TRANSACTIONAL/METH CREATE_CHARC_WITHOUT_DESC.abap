  METHOD create_charc_without_desc.

*--------------------------------------------------------------------*
* Arrangemets
*--------------------------------------------------------------------*

    mo_cut->mt_class_create = VALUE #(
      ( cid              = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid  = th_ngc_bil_cls_data=>cs_class-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class-class
        classtype        = th_ngc_bil_cls_data=>cs_class-classtype
        s_classbasic_new = VALUE #(
          same_value_no = abap_true
          status        = th_ngc_bil_cls_data=>cs_class-classstatus )
        t_operation_log  = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-create_class ) ) ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls_transactional~check_before_save(
      IMPORTING
        et_class_failed   = DATA(lt_class_failed)
        et_class_reported = DATA(lt_class_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_failed
      exp = lt_failed_exp
      msg = 'Expected failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_reported
      exp = lt_reported_exp
      msg = 'Expected reported should be returned' ).

  ENDMETHOD.