  METHOD create.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_create(
      ( %cid                         = th_ngc_bil_cls_data=>cs_class-cid
        class                        = th_ngc_bil_cls_data=>cs_class-class
        classtype                    = th_ngc_bil_cls_data=>cs_class-classtype
        classclassfctnauthgrp        = th_ngc_bil_cls_data=>cs_class-classclassfctnauthgrp
        classmaintauthgrp            = th_ngc_bil_cls_data=>cs_class-classmaintauthgrp
        classsearchauthgrp           = th_ngc_bil_cls_data=>cs_class-classsearchauthgrp
        classstatus                  = th_ngc_bil_cls_data=>cs_class-classstatus
        classgroup                   = th_ngc_bil_cls_data=>cs_class-classgroup
        documentinforecorddocnumber  = th_ngc_bil_cls_data=>cs_class-docnumber
        documentinforecorddocpart    = th_ngc_bil_cls_data=>cs_class-documentpart
        documentinforecorddoctype    = th_ngc_bil_cls_data=>cs_class-documenttype
        documentinforecorddocversion = th_ngc_bil_cls_data=>cs_class-documentversion ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
       ( cid             = th_ngc_bil_cls_data=>cs_class-cid
         classinternalid = th_ngc_bil_cls_data=>cs_class-classinternalid
         class           = th_ngc_bil_cls_data=>cs_class-class
         classtype       = th_ngc_bil_cls_data=>cs_class-classtype
         s_classbasic_new = VALUE #(
           authclassify     = th_ngc_bil_cls_data=>cs_class-classclassfctnauthgrp
           authmaintain     = th_ngc_bil_cls_data=>cs_class-classmaintauthgrp
           authsearch       = th_ngc_bil_cls_data=>cs_class-classsearchauthgrp
           status           = th_ngc_bil_cls_data=>cs_class-classstatus
           classgroup       = th_ngc_bil_cls_data=>cs_class-classgroup
           same_value_no    = abap_true )
         t_operation_log = VALUE #(
          ( cl_ngc_bil_cls=>gc_operation_type-create_class ) ) ) ).

    DATA(lt_mapped_exp) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_mapped(
      ( %cid            = th_ngc_bil_cls_data=>cs_class-cid
        classinternalid = '0000000001' ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~create_class(
      EXPORTING
        it_create   = lt_class
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'Empty failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'Empty reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_mapped
      exp = lt_mapped_exp
      msg = 'Expected mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_class_create
      exp = lt_buffer_exp
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.