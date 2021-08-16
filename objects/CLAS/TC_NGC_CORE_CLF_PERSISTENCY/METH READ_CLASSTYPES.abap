  METHOD read_classtypes.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_classtype) = th_ngc_core_clf_pers_data=>get_classtypes( ).

    me->set_classtypes( lt_classtype ).

    me->get_classtype_data(
      EXPORTING
        it_classtype     = lt_classtype
      IMPORTING
        et_classtype_exp = DATA(lt_classtype_exp) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    DATA(lt_classtype_result) = mo_cut->if_ngc_core_clf_persistency~read_classtypes( ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    me->assert_exp_classtypes(
      it_act = lt_classtype_result
      it_exp = lt_classtype_exp ).

  ENDMETHOD.