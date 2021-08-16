  METHOD get_charc_value_data.

    LOOP AT it_class_charc_with_kdate ASSIGNING FIELD-SYMBOL(<ls_class_charc_with_kdate>).
      LOOP AT <ls_class_charc_with_kdate>-class_charcs ASSIGNING FIELD-SYMBOL(<ls_class_charc>).
        LOOP AT it_charc_value ASSIGNING FIELD-SYMBOL(<ls_charc_value>)
          WHERE
            charcinternalid = <ls_class_charc>-charcinternalid.
          APPEND INITIAL LINE TO et_charc_value_exp ASSIGNING FIELD-SYMBOL(<ls_charc_value_exp>).
          MOVE-CORRESPONDING <ls_charc_value> TO <ls_charc_value_exp>.
          <ls_charc_value_exp>-key_date        = <ls_class_charc_with_kdate>-keydate.
          <ls_charc_value_exp>-classinternalid = <ls_class_charc>-classinternalid.
        ENDLOOP.

        IF line_exists( it_charc_value_inh_overwrite[ charcinternalid = <ls_class_charc>-charcinternalid clfnobjectid = <ls_class_charc>-classinternalid ] ).
          DELETE et_charc_value_exp
            WHERE
              charcinternalid = <ls_class_charc>-charcinternalid AND
              classinternalid = <ls_class_charc>-classinternalid.

          LOOP AT it_charc_value_inh_overwrite ASSIGNING FIELD-SYMBOL(<ls_charc_val_inh_overwr>).
            APPEND INITIAL LINE TO et_charc_value_exp ASSIGNING <ls_charc_value_exp>.
            MOVE-CORRESPONDING <ls_charc_val_inh_overwr> TO <ls_charc_value_exp>.
            <ls_charc_value_exp>-key_date        = <ls_class_charc_with_kdate>-keydate.
            <ls_charc_value_exp>-classinternalid = <ls_class_charc>-classinternalid.
            <ls_charc_value_exp>-charcinternalid = <ls_class_charc>-charcinternalid.
          ENDLOOP.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    SORT et_charc_value_exp BY classinternalid charcinternalid key_date charcvaluepositionnumber.
    DELETE ADJACENT DUPLICATES FROM et_charc_value_exp.

  ENDMETHOD.