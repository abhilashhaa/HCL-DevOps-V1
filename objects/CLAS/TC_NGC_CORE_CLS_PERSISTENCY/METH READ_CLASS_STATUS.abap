  METHOD read_class_status.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->set_class_statuses( th_ngc_core_cls_pers_data=>get_class_statuses( ) ).

    DATA(lt_status) = th_ngc_core_cls_pers_data=>get_class_statuses( ).
    DATA(ls_status) = lt_status[ 1 ].

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    DATA(ls_status_result) = mo_cut->if_ngc_core_cls_persistency~read_class_status(
      iv_classstatus = ls_status-classstatus
      iv_classtype   = ls_status-classtype ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = ls_status_result
      exp = ls_status
      msg = 'Expected status should be returned' ).

  ENDMETHOD.