METHOD recalculate_all.

  DATA(lt_classtype) = mo_clf_persistency->read_classtypes( ).

  LOOP AT lt_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).
    recalculate( <ls_classtype>-classtype ).
  ENDLOOP.

ENDMETHOD.