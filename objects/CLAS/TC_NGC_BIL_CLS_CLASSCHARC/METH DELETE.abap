  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_charc_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
        characteristic  = th_ngc_bil_cls_data=>cs_classcharc_existing-characteristic ) ).

    DATA(lt_class_charc) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_delete(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_classcharc_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
      ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype        = th_ngc_bil_cls_data=>cs_class_existing-classtype
        s_classbasic     = VALUE #(
          same_value_no    = abap_true )
        s_classbasic_new = VALUE #(
          same_value_no    = abap_true )
        t_classcharc     = VALUE #(
         ( charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
           name_char       = th_ngc_bil_cls_data=>cs_classcharc_existing-characteristic ) )
        t_classcharc_new = VALUE #(
         ( charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
           name_char       = th_ngc_bil_cls_data=>cs_classcharc_existing-characteristic
           deletevalue     = abap_true ) )
        t_operation_log  = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-delete_charc ) ) ) ).

    me->set_class( lt_class_db ).
    me->set_class_charc( lt_class_charc_db ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'Initial failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'Initial reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_change
      exp = lt_buffer_exp
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.