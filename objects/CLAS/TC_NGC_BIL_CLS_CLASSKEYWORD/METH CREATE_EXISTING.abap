  METHOD create_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_keyword_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword(
      ( classinternalid            = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language                   = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber ) ).

    DATA(lt_class_keyword) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_create(
      ( %cid_ref              = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid       = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        %target = VALUE #(
          ( %cid              = th_ngc_bil_cls_data=>cs_classkeyword_existing-cid
            classkeywordtext  = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext ) ) ) ).

    me->set_class( lt_class_db ).
    me->set_class_keyword( lt_class_keyword_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class_keyword(
      EXPORTING
        it_create   = lt_class_keyword
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = 1
      msg = 'Expected failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      exp = 1
      act = lines( lt_reported )
      msg = 'Expected reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_mapped
      msg = 'Initial mapped expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_class_change
      msg = 'Initial buffer expected' ).

  ENDMETHOD.