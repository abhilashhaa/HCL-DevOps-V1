  METHOD create_no_desc.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).


    DATA(lt_class_keyword) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_create(
      ( %cid_ref              = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid       = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        %target = VALUE #(
          ( %cid              = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-cid
            language          = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-language
            classkeywordtext  = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-classkeywordtext ) ) ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-language ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language        = th_ngc_bil_cls_data=>cs_classkeyword_new_langu-language ) ).

    me->set_class( lt_class_db ).

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

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_class_change
      msg = 'Initial buffer expected' ).

  ENDMETHOD.