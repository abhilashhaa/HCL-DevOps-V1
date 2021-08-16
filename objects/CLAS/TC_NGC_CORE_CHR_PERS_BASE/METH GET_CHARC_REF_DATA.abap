  METHOD get_charc_ref_data.

    LOOP AT it_charc_ref ASSIGNING FIELD-SYMBOL(<lt_charc_ref_table>).
      LOOP AT <lt_charc_ref_table> ASSIGNING FIELD-SYMBOL(<ls_charc_ref>).
        APPEND INITIAL LINE TO et_charc_ref_exp ASSIGNING FIELD-SYMBOL(<ls_charc_ref_exp>).
        MOVE-CORRESPONDING <ls_charc_ref> TO <ls_charc_ref_exp>.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.