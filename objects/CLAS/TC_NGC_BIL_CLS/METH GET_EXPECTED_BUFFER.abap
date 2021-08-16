  METHOD get_expected_buffer.

    rt_buffer = VALUE cl_ngc_bil_cls=>lty_t_class_change(
   (  classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
      class           = th_ngc_bil_cls_data=>cs_class_existing-class
      classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype
      s_classbasic-same_value_no     = abap_true
      s_classbasic_new-same_value_no = abap_true
      t_classdesc = VALUE #(
        ( langu          = th_ngc_bil_cls_data=>cs_classdesc_existing-language
          catchword      = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription )
      )
      t_classkeyword = VALUE #(
        ( langu          = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
          catchword      = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext
          classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber )
      )
      t_classkeyword_new = VALUE #(
        ( langu          = th_ngc_bil_cls_data=>cs_classkeyword_existing-language
          catchword      = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordtext
          classkeywordpositionnumber = th_ngc_bil_cls_data=>cs_classkeyword_existing-classkeywordpositionnumber )
      )
      t_classtext = VALUE #(
       ( langu         = th_ngc_bil_cls_data=>cs_classdesc_existing-language
         text_type     = shift_left( val = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 places = 2 )
         text_descr    = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00 )
       ( langu         = th_ngc_bil_cls_data=>cs_classdesc_existing-language
         text_type     = shift_left( val = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_01 places = 2 )
         text_descr    = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_01 )
      )
      t_classdesc_new = VALUE #(
        ( catchword  = th_ngc_bil_cls_data=>cs_classdesc_existing-classdescription
          langu      = th_ngc_bil_cls_data=>cs_classdesc_existing-language )
      )
      t_classtext_new = VALUE #(
        ( text_type  = shift_left( val = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_00 places = 2 )
          text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_00
          langu      = th_ngc_bil_cls_data=>cs_classtext_existing-language )
        ( text_type  = shift_left( val = th_ngc_bil_cls_data=>cs_classtext_existing-longtextid_01 places = 2 )
          text_descr = th_ngc_bil_cls_data=>cs_classtext_existing-classtext_01
          langu      = th_ngc_bil_cls_data=>cs_classtext_existing-language )
      )
      t_classcharc  = VALUE #(
       ( charcinternalid       = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
         name_char           = th_ngc_bil_cls_data=>cs_charc_existing-characteristic
         select_relev         = th_ngc_bil_cls_data=>cs_classcharc_existing-charcissearchrelevant )
      )
      t_classcharc_new  = VALUE #(
       ( charcinternalid       = th_ngc_bil_cls_data=>cs_classcharc_existing-charcinternalid
         name_char           = th_ngc_bil_cls_data=>cs_charc_existing-characteristic
         select_relev         = th_ngc_bil_cls_data=>cs_classcharc_existing-charcissearchrelevant )
      )
) ).

  ENDMETHOD.