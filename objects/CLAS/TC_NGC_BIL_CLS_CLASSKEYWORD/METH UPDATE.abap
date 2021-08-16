  METHOD update.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class           = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype ) ).

    DATA(lt_class_desc_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classdesc(
      ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language         = sy-langu
        classdescription = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription ) ).

    DATA(lt_class_keyword_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword(
      ( classinternalid            = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language                   = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber
        classkeywordtext           = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext ) ).

    DATA(lt_class_keyword) = VALUE if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_update(
      ( %cid_ref                   = th_ngc_bil_cls_data=>cs_classkeyword_existing-cid
        classinternalid            = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        language                   = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
        classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber
        classkeywordtext           = th_ngc_bil_cls_data=>cs_classkeyword_new-classkeywordtext
        %control                   = VALUE #(
           classkeywordtext = cl_abap_behavior_handler=>flag_changed ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
      ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype        = th_ngc_bil_cls_data=>cs_class_existing-classtype
        s_classbasic     = VALUE #(
          same_value_no    = abap_true )
        s_classbasic_new = VALUE #(
          same_value_no    = abap_true )
        t_classdesc      = VALUE #(
          ( langu = sy-langu catchword = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription ) )
        t_classdesc_new  = VALUE #(
          ( langu = sy-langu catchword = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription ) )
        t_classkeyword     = VALUE #(
          ( classkeywordpositionnumber = '02' catchword = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext langu = sy-langu ) )
        t_classkeyword_new = VALUE #(
          ( classkeywordpositionnumber = '02' catchword = th_ngc_bil_cls_data=>cs_classkeyword_new-classkeywordtext langu = sy-langu ) )
        t_operation_log  = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-update_keyword ) ) ) ).

    me->set_class( lt_class_db ).
    me->set_class_desc( lt_class_desc_db ).
    me->set_class_keyword( lt_class_keyword_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~update_class_keyword(
      EXPORTING
        it_update   = lt_class_keyword
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
      msg = 'classkeyword update: a class should be buffered' ).

  ENDMETHOD.