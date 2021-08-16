  METHOD delete_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_delete(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_class_not_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_not_existing-classinternalid ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_class_not_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_not_existing-classinternalid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_class_not_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_not_existing-classinternalid ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~delete_class(
      EXPORTING
        it_delete   = lt_class
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
      act = mo_cut->mt_class_create
      msg = 'Initial buffer expected' ).

  ENDMETHOD.