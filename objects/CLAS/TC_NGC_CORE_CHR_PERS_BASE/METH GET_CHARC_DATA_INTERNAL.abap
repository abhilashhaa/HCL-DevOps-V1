  METHOD GET_CHARC_DATA_INTERNAL.

    LOOP AT it_characteristic_with_keydate ASSIGNING FIELD-SYMBOL(<ls_characteristic_with_kdate>).
      LOOP AT <ls_characteristic_with_kdate>-characteristics ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
        APPEND VALUE #(
          charcinternalid = <ls_characteristic>-charcinternalid
          key_date        = <ls_characteristic_with_kdate>-keydate ) TO et_characteristic_in.

        APPEND INITIAL LINE TO et_characteristic_exp ASSIGNING FIELD-SYMBOL(<ls_characteristic_exp>).
        MOVE-CORRESPONDING <ls_characteristic> TO <ls_characteristic_exp>.
        <ls_characteristic_exp>-key_date = <ls_characteristic_with_kdate>-keydate.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.