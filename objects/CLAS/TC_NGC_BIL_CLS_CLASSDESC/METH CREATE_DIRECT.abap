  METHOD create_direct.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_desc) = VALUE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_create_direct(
      ( %cid             = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        classdescription = th_ngc_bil_cls_data=>cs_classdesc_new-classdescription ) ).

    DATA(lt_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_mapped(
      ( %cid            = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = sy-langu ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
       ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
         class            = th_ngc_bil_cls_data=>cs_class_existing-class
         classtype        = th_ngc_bil_cls_data=>cs_class_existing-classtype
         s_classbasic     = VALUE #(
           same_value_no    = abap_true )
         s_classbasic_new = VALUE #(
           same_value_no    = abap_true )
         t_classdesc_new  = VALUE #(
          ( langu = sy-langu catchword = th_ngc_bil_cls_data=>cs_classdesc_new-classdescription ) )
         t_operation_log  = VALUE #(
           ( cl_ngc_bil_cls=>gc_operation_type-create_desc ) ) ) ).

    me->set_class( lt_class_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class_desc_direct(
      EXPORTING
        it_create   = lt_class_desc
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

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
      act = lt_mapped
      exp = lt_mapped_exp
      msg = 'Expected mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_change
      exp = lt_buffer_exp
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.