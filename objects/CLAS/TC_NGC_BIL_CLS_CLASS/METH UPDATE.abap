  METHOD update.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_class_db) = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_class(
      ( classinternalid = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        classtype       = th_ngc_bil_cls_data=>cs_class_existing-classtype
        class           = th_ngc_bil_cls_data=>cs_class_existing-class ) ).

    DATA(lt_class) = VALUE if_ngc_bil_cls_c=>lty_clfnclasstp-t_update(
      ( %cid_ref             = th_ngc_bil_cls_data=>cs_class_existing-cid
        classinternalid      = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        classsearchauthgrp   = th_ngc_bil_cls_data=>cs_class_update-classsearchauthgrp
        classgroup           = th_ngc_bil_cls_data=>cs_class_update-classgroup
        %control             = VALUE  #(
          classgroup         = cl_abap_behavior_handler=>flag_changed
          classsearchauthgrp = cl_abap_behavior_handler=>flag_changed ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_cls=>lty_t_class_change(
      ( classinternalid  = th_ngc_bil_cls_data=>cs_class_existing-classinternalid
        class            = th_ngc_bil_cls_data=>cs_class_existing-class
        classtype        = th_ngc_bil_cls_data=>cs_class_existing-classtype
        s_classbasic     = VALUE #(
          same_value_no = abap_true )
        s_classbasic_new = VALUE #(
          authsearch    = th_ngc_bil_cls_data=>cs_class_update-classsearchauthgrp
          classgroup    = th_ngc_bil_cls_data=>cs_class_update-classgroup
          same_value_no = abap_true )
        t_operation_log  = VALUE #(
         ( cl_ngc_bil_cls=>gc_operation_type-update_class ) ) ) ).

    me->set_class( lt_class_db ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~update_class(
      EXPORTING
        it_update   = lt_class
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
      msg = 'Expected buffer should be read' ).

  ENDMETHOD.