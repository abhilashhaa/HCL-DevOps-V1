  METHOD adjust_numbers_create.

*--------------------------------------------------------------------*
* Arrangemets
*--------------------------------------------------------------------*

    cl_abap_testdouble=>configure_call( mo_cut->mo_ngc_db_access )->returning( th_ngc_bil_cls_data=>cs_class_existing-classinternalid ).
    mo_cut->mo_ngc_db_access->get_classintid_from_buffer(
      iv_class     = th_ngc_bil_cls_data=>cs_class-class
      iv_classtype = th_ngc_bil_cls_data=>cs_class-classtype ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_ngc_db_access )->returning( VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classkeyword( classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber2 ) ).
    mo_cut->mo_ngc_db_access->get_classkeyword_from_buffer( VALUE #(
      classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
      language         = th_ngc_bil_cls_data=>cs_classkeyword-language_en
      classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext1 ) ).

    mo_cut->mt_class_create = VALUE #(
      ( cid                = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid    = th_ngc_bil_cls_data=>cs_class-classinternalid
        class              = th_ngc_bil_cls_data=>cs_class-class
        classtype          = th_ngc_bil_cls_data=>cs_class-classtype
        s_classbasic_new   = VALUE #(
          same_value_e  = abap_true
          status        = th_ngc_bil_cls_data=>cs_class-classstatus )
        t_classtext_new    = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classtext_existing-language text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 text_type = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 fldelete = abap_true ) )
        t_classdesc_new    = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classdesc_existing-language catchword = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription ) )
        t_classkeyword_new = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classkeyword-language_en classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber1 catchword = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext1 created = abap_true ) )
        t_classcharc_new   = VALUE #(
          ( charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ) )
        t_operation_log    = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-delete_text ) ) ) ).

    DATA(lt_class_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_mapped_late(
      ( %tmp-classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        classinternalid      = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

    DATA(lt_class_desc_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_mapped_late(
      ( %tmp-classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        %tmp-language        = th_ngc_bil_cls_data=>cs_classdesc_existing-language
        classinternalid      = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language             = th_ngc_bil_cls_data=>cs_classdesc_existing-language ) ).

    DATA(lt_class_keyword_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_mapped_late(
      ( %tmp-classinternalid            = th_ngc_bil_cls_data=>cs_class-classinternalid
        %tmp-language                   = th_ngc_bil_cls_data=>cs_classkeyword-language_en
        %tmp-classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber1
        classinternalid                 = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language                        = th_ngc_bil_cls_data=>cs_classkeyword-language_en
        classkeywordpositionnumber      = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber2 ) ).

    DATA(lt_class_text_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_mapped_late(
      ( %tmp-classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        %tmp-language        = th_ngc_bil_cls_data=>cs_classtext_existing-language
        %tmp-longtextid      = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00
        classinternalid      = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language             = th_ngc_bil_cls_data=>cs_classtext_existing-language
        longtextid           = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 ) ).

    DATA(lt_class_charc_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_mapped_late(
      ( %tmp-classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
        %tmp-charcinternalid = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid
        classinternalid      = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        charcinternalid      = th_ngc_bil_cls_data=>cs_charc_existing-charcinternalid ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls_transactional~adjust_numbers(
      IMPORTING
        et_class_mapped         = DATA(lt_class_mapped)
        et_class_desc_mapped    = DATA(lt_class_desc_mapped)
        et_class_keyword_mapped = DATA(lt_class_keyword_mapped)
        et_class_text_mapped    = DATA(lt_class_text_mapped)
        et_class_charc_mapped   = DATA(lt_class_charc_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_mapped
      exp = lt_class_mapped_exp
      msg = 'Expected class mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_desc_mapped
      exp = lt_class_desc_mapped_exp
      msg = 'Expected class desc mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_keyword_mapped
      exp = lt_class_keyword_mapped_exp
      msg = 'Expected class keyword mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_text_mapped
      exp = lt_class_text_mapped_exp
      msg = 'Expected class text mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_charc_mapped
      exp = lt_class_charc_mapped_exp
      msg = 'Expected class charc mapped should be returned' ).

  ENDMETHOD.