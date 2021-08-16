  METHOD create_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_text_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00
        classtext       = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 ) ).

    DATA(lt_text_id_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext_id(
      ( klart = th_ngc_bil_cls_data=>cs_class_existing-classtype txida = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00+2 )
      ( klart = th_ngc_bil_cls_data=>cs_class_existing-classtype txida = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_01+2 ) ).

    DATA(lt_class_text) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_create(
      ( %cid_ref              = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid       = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        %target = VALUE #(
          ( %cid        = th_ngc_bil_cls_data=>cs_classtext_existing-cid
            longtextid  = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00
            language    = th_ngc_bil_cls_data=>cs_classtext_existing-language
            classtext   = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 ) ) ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_classtext_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_classtext_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
      ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype        = th_ngc_bil_cls_data=>cs_class_existing-classtype
        s_classbasic     = VALUE #(
          same_value_no    = abap_true )
        s_classbasic_new = VALUE #(
          same_value_no    = abap_true )
        t_classtext      = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classtext_existing-language text_type = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 ) )
        t_classtext_new  = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classtext_existing-language text_type = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 ) ) ) ).

    me->set_class( lt_class_db ).
    me->set_class_text( lt_class_text_db ).
    me->set_text_id( lt_text_id_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class_text(
      EXPORTING
        it_create   = lt_class_text
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
      msg = 'Initial mapped expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_change
      exp = lt_buffer_exp
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.