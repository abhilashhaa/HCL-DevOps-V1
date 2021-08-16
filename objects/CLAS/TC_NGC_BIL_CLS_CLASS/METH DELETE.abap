  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_delete(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

    me->set_class( lt_class_db ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'Initial failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'Initial reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_delete
      exp = lt_class
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.