  METHOD get_valuation_for_class.

    DATA(ls_class) = io_assigned_class->get_header( ).

    CHECK ls_class-sameclassfctnreaction IS NOT INITIAL AND
          ls_class-sameclassfctnreaction <> 'X'.

    io_assigned_class->get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristic) ).

    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_char>).
      LOOP AT it_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>)
        WHERE
          charcinternalid = <ls_class_char>-charcinternalid.

        " TODO: Check redundant
        IF <ls_class_char>-characteristic_object->get_header( )-charcreferencetable IS INITIAL.
          APPEND <ls_valuation_data> TO rt_valuation_data.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.