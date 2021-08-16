  METHOD create_no_desc_in_langu.
*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_create(
      ( %cid                     = th_ngc_bil_cls_data=>cs_class-cid
        class                    = th_ngc_bil_cls_data=>cs_class-class
        classinternalid          = th_ngc_bil_cls_data=>cs_class-classinternalid
        classtype                = th_ngc_bil_cls_data=>cs_class-classtype )
    ).

    DATA(lt_classdesc) = VALUE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_create(
          ( %cid_ref             = th_ngc_bil_cls_data=>cs_class-cid
            classinternalid      = th_ngc_bil_cls_data=>cs_class-classinternalid
            %target = VALUE #(
             ( %cid              = th_ngc_bil_cls_data=>cs_classdesc_new-cid
               language          = th_ngc_bil_cls_data=>cs_classdesc_new-language
               classdescription  = th_ngc_bil_cls_data=>cs_classdesc_new-classdescription   )
    ) ) ).

    DATA(lt_classkeyword) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_create(
          ( %cid_ref = th_ngc_bil_cls_data=>cs_class-cid
            classinternalid          = th_ngc_bil_cls_data=>cs_class-classinternalid
            %target = VALUE #(
             ( %cid             = th_ngc_bil_cls_data=>cs_classkeyword-cid1
               language         = th_ngc_bil_cls_data=>cs_classkeyword-language_en
               classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext1   )
             ( %cid             = th_ngc_bil_cls_data=>cs_classkeyword-cid2
               language         = th_ngc_bil_cls_data=>cs_classkeyword-language_en
               classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext2   )
             ( %cid             = th_ngc_bil_cls_data=>cs_classkeyword-cid3
               language         = th_ngc_bil_cls_data=>cs_classkeyword-language_de
               classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext3   )
             ( %cid             = th_ngc_bil_cls_data=>cs_classkeyword-cid4
               language         = th_ngc_bil_cls_data=>cs_classkeyword-language_de
               classkeywordtext = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordtext4   )
    ) ) ).

    DATA(lt_class_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_mapped(
      ( %cid            = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid )
    ).
    DATA(lt_classdesc_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_mapped(
      ( %cid            = th_ngc_bil_cls_data=>cs_classdesc_new-cid
        language        = th_ngc_bil_cls_data=>cs_classdesc_new-language
        classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid )
    ).
    DATA(lt_classkeyword_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_mapped(
      ( %cid                       = th_ngc_bil_cls_data=>cs_classkeyword-cid3
        classinternalid            = th_ngc_bil_cls_data=>cs_class-classinternalid
        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber3
        language                   = th_ngc_bil_cls_data=>cs_classkeyword-language_de )
      ( %cid                       = th_ngc_bil_cls_data=>cs_classkeyword-cid4
        classinternalid            = th_ngc_bil_cls_data=>cs_class-classinternalid
        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword-classkeywordpositionnumber4
        language                   = th_ngc_bil_cls_data=>cs_classkeyword-language_de )
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_bil_cls~create_class(
      EXPORTING
        it_create   = lt_class
      IMPORTING
        et_failed   = DATA(lt_class_failed)
        et_reported = DATA(lt_class_reported)
        et_mapped   = DATA(lt_class_mapped) ).

    mo_cut->if_ngc_bil_cls~create_class_desc(
      EXPORTING
        it_create   = lt_classdesc
      IMPORTING
        et_failed   = DATA(lt_classdesc_failed)
        et_reported = DATA(lt_classdesc_reported)
        et_mapped   = DATA(lt_classdesc_mapped) ).

    mo_cut->if_ngc_bil_cls~create_class_keyword(
      EXPORTING
        it_create   = lt_classkeyword
      IMPORTING
        et_failed   = DATA(lt_classkeyword_failed)
        et_reported = DATA(lt_classkeyword_reported)
        et_mapped   = DATA(lt_classkeyword_mapped) ).

    mo_cut->if_ngc_bil_cls_transactional~check_before_save(
      IMPORTING
        et_class_failed        = DATA(lt_before_failed)
        et_class_reported      = DATA(lt_before_reported) ).
*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_before_failed )
      exp = 0
      msg = 'class create no desc in langu: no failed expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_before_reported )
      exp = 0
      msg = 'class create no desc in langu: no reported expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_class_failed
      msg = 'class create no desc in langu: no failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_class_reported
      msg = 'class create no desc in langu: no reported expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_classdesc_failed
      msg = 'class create no desc in langu: no failed expected (classdesc)' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_classkeyword_failed )
      exp = 2
      msg = 'class create no desc in langu: 2 failed expected (classkeyword)' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_classdesc_reported
      msg = 'class create no desc in langu: no reported expected (classdesc)' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_classkeyword_reported )
      exp = 2
      msg = 'class create no desc in langu: 2 reported expected (classkeyword)' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_class_mapped
      exp = lt_class_mapped_exp
      msg = 'class create no desc in langu: expected mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_classdesc_mapped
      exp = lt_classdesc_mapped_exp
      msg = 'class create no desc in langu: expected mapped should be returned (classdesc)' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_classkeyword_mapped
      exp = lt_classkeyword_mapped_exp
      msg = 'class create no desc in langu: expected mapped should be returned (classkeyword)' ).

  ENDMETHOD.