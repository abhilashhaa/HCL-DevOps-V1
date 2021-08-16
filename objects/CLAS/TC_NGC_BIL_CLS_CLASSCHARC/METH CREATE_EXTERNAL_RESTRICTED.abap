  METHOD create_external_restricted.

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

    DATA(lt_charc_rstrcn_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_charcrstrcn(
      ( charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_restricted-charcinternalid
        classtype       = th_ngc_bil_cls_data=>cs_classcharc_restricted-classtype_1 )
      ( charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_restricted-charcinternalid
        classtype       = th_ngc_bil_cls_data=>cs_classcharc_restricted-classtype_2 )
    ).

    DATA(lt_charc_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_charc(
      ( charcinternalid = th_ngc_bil_cls_data=>cs_classcharc_restricted-charcinternalid
        characteristic  = th_ngc_bil_cls_data=>cs_classcharc_restricted-characteristic ) ).

    DATA(lt_class_charc) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_create(
      ( %cid_ref        = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        %target         = VALUE #(
          ( %cid           = th_ngc_bil_cls_data=>cs_classcharc_restricted-cid
            characteristic = th_ngc_bil_cls_data=>cs_classcharc_restricted-characteristic ) ) ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_failed(
      ( %cid            = th_ngc_bil_cls_data=>cs_classcharc_restricted-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_reported(
      ( %cid            = th_ngc_bil_cls_data=>cs_classcharc_restricted-cid
        classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid ) ).

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
            name_char       = th_ngc_bil_cls_data=>cs_classcharc_existing-characteristic ) ) ) ).

    me->set_class( lt_class_db ).
    me->set_class_charc( lt_class_charc_db ).
    me->set_charc( lt_charc_db ).
    me->set_charc_rstrcn( lt_charc_rstrcn_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class_charc(
      EXPORTING
        it_create   = lt_class_charc
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
      msg = 'Initial mapping expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_change
      exp = lt_buffer_exp
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.