  METHOD set_reference_charc_valuation.

    DATA:
      lt_change_value TYPE ngct_valuation_charcvalue_chg.

    FIELD-SYMBOLS:
      <lv_charcvalue> TYPE any.

    DATA(ls_header) = is_class_object-class_object->get_header( ).
    is_class_object-class_object->get_characteristics(
      IMPORTING
        et_characteristic  = DATA(lt_characteristic)
    ).
    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      DATA(lt_characteristic_ref) = <ls_characteristic>-characteristic_object->get_characteristic_ref( ).

      LOOP AT lt_characteristic_ref ASSIGNING FIELD-SYMBOL(<ls_characteristic_ref>).
        CLEAR: lt_change_value.

        IF line_exists( mt_reference_data[ charcreferencetable = <ls_characteristic_ref>-charcreferencetable ] ).
          READ TABLE mt_reference_data ASSIGNING FIELD-SYMBOL(<ls_reference_data>)
            WITH KEY
              charcreferencetable = <ls_characteristic_ref>-charcreferencetable.

          DATA(ls_change_value) = VALUE ngcs_valuation_charcvalue_chg(
                                       classtype        = ls_header-classtype
                                       charcinternalid  = <ls_characteristic>-charcinternalid
          ).
          ASSIGN <ls_reference_data>-data->* TO FIELD-SYMBOL(<ls_data>).
          ASSIGN COMPONENT <ls_characteristic_ref>-charcreferencetablefield OF STRUCTURE <ls_data> TO <lv_charcvalue>.
          ls_change_value-charcvaluenew = <lv_charcvalue>.
          APPEND ls_change_value TO lt_change_value.
          mv_skip_checks_for_ref_charc = abap_true.
          if_ngc_classification~change_values(
            EXPORTING
              it_change_value   = lt_change_value
*           IMPORTING
*             eo_clf_api_result = data(lo_clf_api_result)
          ).
          mv_skip_checks_for_ref_charc = abap_false.

          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.