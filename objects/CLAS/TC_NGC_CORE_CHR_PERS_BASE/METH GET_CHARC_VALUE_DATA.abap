  METHOD get_charc_value_data.

    LOOP AT it_charc_value ASSIGNING FIELD-SYMBOL(<ls_charc_value_with_kdate>).
      LOOP AT <ls_charc_value_with_kdate>-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value>).
        APPEND INITIAL LINE TO et_charc_value_exp ASSIGNING FIELD-SYMBOL(<ls_charc_value_exp>).
        MOVE-CORRESPONDING <ls_charc_value> TO <ls_charc_value_exp>.
        <ls_charc_value_exp>-key_date = <ls_charc_value_with_kdate>-keydate.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.