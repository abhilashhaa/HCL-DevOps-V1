  METHOD adjust_numbers_change.

*--------------------------------------------------------------------*
* Arrangemets
*--------------------------------------------------------------------*

    cl_abap_testdouble=>configure_call( mo_cut->mo_ngc_db_access )->returning( VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-s_classkeyword( classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber2 ) ).
    mo_cut->mo_ngc_db_access->get_classkeyword_from_buffer( VALUE #(
      classinternalid  = th_ngc_bil_cls_data=>cs_class-classinternalid
      language         = th_ngc_bil_cls_data=>cs_classkeyword-language_en
      classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext1 ) ).

    mo_cut->mt_class_change = VALUE #(
      ( cid                = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid    = th_ngc_bil_cls_data=>cs_class-classinternalid
        class              = th_ngc_bil_cls_data=>cs_class-class
        classtype          = th_ngc_bil_cls_data=>cs_class-classtype
        s_classbasic_new   = VALUE #(
          same_value_e  = abap_true
          status        = th_ngc_bil_cls_data=>cs_class-classstatus )
        t_classkeyword_new = VALUE #(
          ( langu = th_ngc_bil_cls_data=>cs_classkeyword-language_en classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber1 catchword = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext1 created = abap_true ) )
        t_operation_log    = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-create_keyword ) ) ) ).

    DATA(lt_class_keyword_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_mapped_late(
      ( %tmp-classinternalid            = th_ngc_bil_cls_data=>cs_class-classinternalid
        %tmp-language                   = th_ngc_bil_cls_data=>cs_classkeyword-language_en
        %tmp-classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber1
        classinternalid                 = th_ngc_bil_cls_data=>cs_class-classinternalid
        language                        = th_ngc_bil_cls_data=>cs_classkeyword-language_en
        classkeywordpositionnumber      = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber2 ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls_transactional~adjust_numbers(
      IMPORTING
        et_class_keyword_mapped = DATA(lt_class_keyword_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_keyword_mapped
      exp = lt_class_keyword_mapped_exp
      msg = 'Expected class keyword mapped should be returned' ).

  ENDMETHOD.