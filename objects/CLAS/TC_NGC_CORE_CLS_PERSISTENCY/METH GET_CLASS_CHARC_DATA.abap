  METHOD get_class_charc_data.

    LOOP AT it_class_charc_with_kdate ASSIGNING FIELD-SYMBOL(<ls_class_chr_with_kdate>).
      LOOP AT <ls_class_chr_with_kdate>-class_charcs ASSIGNING FIELD-SYMBOL(<ls_class_charc>).
        APPEND VALUE #(
          charcinternalid            = <ls_class_charc>-charcinternalid
          overwrittencharcinternalid = <ls_class_charc>-overwrittencharcinternalid
          key_date                   = <ls_class_chr_with_kdate>-keydate ) TO et_characteristic_key.

        APPEND INITIAL LINE TO et_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
        MOVE-CORRESPONDING <ls_class_charc> TO <ls_characteristic>.
        <ls_characteristic>-key_date = <ls_class_chr_with_kdate>-keydate.

        APPEND INITIAL LINE TO et_class_charc_exp ASSIGNING FIELD-SYMBOL(<ls_class_charc_exp>).
        MOVE-CORRESPONDING <ls_class_charc> TO <ls_class_charc_exp>.
        <ls_class_charc_exp>-key_date = <ls_class_chr_with_kdate>-keydate.

      ENDLOOP.
    ENDLOOP.

    SORT et_characteristic_key BY charcinternalid.
    DELETE ADJACENT DUPLICATES FROM et_characteristic_key.

  ENDMETHOD.