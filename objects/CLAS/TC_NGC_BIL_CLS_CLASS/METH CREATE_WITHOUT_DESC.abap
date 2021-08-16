  METHOD create_without_desc.
*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_create(
      ( %cid                     = th_ngc_bil_cls_data=>cs_class_wo_description-cid
        class                    = th_ngc_bil_cls_data=>cs_class_wo_description-class
        classtype                = th_ngc_bil_cls_data=>cs_class_wo_description-classtype )
    ).

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

    mo_cut->if_ngc_bil_cls_transactional~check_before_save(
      IMPORTING
        et_class_failed        = DATA(lt_class_failed)
        et_class_reported      = DATA(lt_class_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = 0
      msg = 'class w/o desc: no failed expected' ).

    cl_abap_unit_assert=>assert_equals(
      exp = 0
      act = lines( lt_reported )
      msg = 'class w/o desc: no reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_class_failed )
      exp = 1
      msg = 'class w/o desc: no failed expected' ).

    cl_abap_unit_assert=>assert_equals(
      exp = 1
      act = lines( lt_class_reported )
      msg = 'class w/o desc: no reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_mapped )
      exp = 1
      msg = 'class w/o desc: no mapped expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( mo_cut->mt_class_create )
      exp = 1
      msg = 'class w/o desc: class should be buffered' ).

  ENDMETHOD.