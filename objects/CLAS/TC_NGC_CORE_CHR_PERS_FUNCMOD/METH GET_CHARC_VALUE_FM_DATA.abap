  METHOD get_charc_value_fm_data.

    LOOP AT it_charc_value ASSIGNING FIELD-SYMBOL(<ls_charc_value>).
      APPEND VALUE #(
        value     = <ls_charc_value>-charcvalue
        status    = 1
        val_descr = <ls_charc_value>-charcvaluedescription ) TO et_charc_value_in.

      APPEND INITIAL LINE TO et_charc_value_exp ASSIGNING FIELD-SYMBOL(<ls_charc_value_exp>).
      MOVE-CORRESPONDING <ls_charc_value> TO <ls_charc_value_exp>.
      <ls_charc_value_exp>-charcvaluedependency  = 1.
      <ls_charc_value_exp>-key_date              = <ls_charc_value>-keydate.

      IF <ls_charc_value>-phrase IS NOT INITIAL.
        <ls_charc_value_exp>-charcvaluedescription = |{ <ls_charc_value>-phrase }: { <ls_charc_value_exp>-charcvaluedescription }|.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.