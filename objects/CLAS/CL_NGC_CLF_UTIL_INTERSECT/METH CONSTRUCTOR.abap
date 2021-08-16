METHOD constructor.

  DATA:
    lv_classtype TYPE klassenart.

  mo_util_intersect  = cl_ngc_core_cls_util_intersect=>get_instance( ).
  mo_clf_persistency = cl_ngc_core_factory=>get_clf_persistency( ).

  DATA(lt_classtype) = mo_clf_persistency->read_classtypes( ).

  SORT lt_classtype ASCENDING BY classtype.

  LOOP AT lt_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).
    IF lv_classtype = <ls_classtype>-classtype.
      CONTINUE.
    ENDIF.
    lv_classtype = <ls_classtype>-classtype.
    APPEND VALUE #( sign   = if_ngc_core_c=>gc_range_sign-include
                    option = if_ngc_core_c=>gc_range_option-equals
                    low    = lv_classtype
                    high   = space ) TO me->mt_recalc_classtype_range.
  ENDLOOP.

ENDMETHOD.