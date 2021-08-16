  METHOD read_classtype.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_classtype) = th_ngc_core_clf_pers_data=>get_classtypes( ).
    DATA(ls_classtype) = lt_classtype[ 1 ].

    me->set_classtypes( lt_classtype ).

    me->get_classtype_data(
      EXPORTING
        it_classtype = VALUE #( ( ls_classtype ) )
      IMPORTING
        et_classtype_exp = DATA(lt_classtype_exp) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    DATA(ls_classtype_result) = mo_cut->if_ngc_core_clf_persistency~read_classtype(
        iv_classtype       = ls_classtype-classtype
        iv_clfnobjecttable = ls_classtype-clfnobjecttable ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = ls_classtype_result
      exp = lt_classtype_exp[ 1 ]
      msg = 'Expected class type should be read' ).

  ENDMETHOD.