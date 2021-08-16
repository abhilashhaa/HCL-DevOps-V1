  METHOD get_classtype_data.

    LOOP AT it_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).
      APPEND INITIAL LINE TO et_classtype_exp ASSIGNING FIELD-SYMBOL(<ls_classtype_exp>).
      MOVE-CORRESPONDING <ls_classtype> TO <ls_classtype_exp>.
    ENDLOOP.

  ENDMETHOD.