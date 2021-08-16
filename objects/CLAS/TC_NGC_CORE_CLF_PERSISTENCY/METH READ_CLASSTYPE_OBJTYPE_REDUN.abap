  METHOD read_classtype_objtype_redun.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_classtype) = th_ngc_core_clf_pers_data=>get_classtypes( ).
    DATA(ls_classtype) = lt_classtype[ 1 ].
    me->set_classtypes( lt_classtype ).

    DATA(lt_tclao) = th_ngc_core_clf_pers_data=>get_classtypes_objtype_redun( ).

    me->set_classtypes_objtype_redun( lt_tclao ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    DATA(lv_charcredundantstorisallowed) = mo_cut->if_ngc_core_clf_persistency~read_classtype_objtype_redun(
      iv_classtype       = ls_classtype-classtype
      iv_clfnobjecttable = ls_classtype-clfnobjecttable ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lv_charcredundantstorisallowed
      exp = abap_true
      msg = 'Redundancy flag should be true' ).

  ENDMETHOD.