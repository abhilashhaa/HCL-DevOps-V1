  METHOD create_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_existing_class) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_create(
      ( %cid      = th_ngc_bil_cls_data=>cs_class_existing-cid
        class     = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    me->set_class( lt_existing_class ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_failed(
      ( %cid = th_ngc_bil_cls_data=>cs_class_existing-cid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_reported(
      ( %cid = th_ngc_bil_cls_data=>cs_class_existing-cid ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class(
      EXPORTING
        it_create   = lt_class
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

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
      act = lt_mapped
      msg = 'No mapping expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_class_create
      msg = 'Initial buffer expected' ).

  ENDMETHOD.