  METHOD delete_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_charc_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_charc(
      ( charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid
        characteristic  = th_ngc_bil_cls_data=>cs_charc_existing-characteristic ) ).

    DATA(lt_class_charc) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_delete(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_charc_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_charc_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_charc_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ) ).

    me->set_class( lt_class_db ).
    me->set_charc( lt_charc_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~delete_class_charc(
      EXPORTING
        it_delete   = lt_class_charc
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