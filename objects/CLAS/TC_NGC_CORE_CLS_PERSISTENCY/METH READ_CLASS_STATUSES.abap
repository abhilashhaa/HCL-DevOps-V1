  METHOD read_class_statuses.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA:
      lt_status TYPE STANDARD TABLE OF i_clfnclassstatus.


    me->set_class_statuses( th_ngc_core_cls_pers_data=>get_class_statuses( ) ).

    LOOP AT th_ngc_core_cls_pers_data=>get_class_statuses( ) ASSIGNING FIELD-SYMBOL(<ls_status>)
      WHERE
        classtype = th_ngc_core_cls_pers_data=>cv_classtype_001.
      APPEND <ls_status> TO lt_status.
    ENDLOOP.

    me->get_class_status_data(
      EXPORTING
        it_class_status     = lt_status
      IMPORTING
        et_class_status_exp = DATA(lt_status_exp) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    DATA(lt_status_for_classtype) = mo_cut->if_ngc_core_cls_persistency~read_class_statuses( th_ngc_core_cls_pers_data=>cv_classtype_001 ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    me->assert_exp_statuses(
      it_act = lt_status_for_classtype
      it_exp = lt_status_exp ).

  ENDMETHOD.