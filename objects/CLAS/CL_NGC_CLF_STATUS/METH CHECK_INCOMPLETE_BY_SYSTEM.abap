  METHOD check_incomplete_by_system.

    io_classification->get_assigned_classes(
      IMPORTING
        et_assigned_class = DATA(lt_assigned_class) ).

    io_classification->get_assigned_values(
      IMPORTING
        et_valuation_data = DATA(lt_valuation_data) ).

    READ TABLE lt_assigned_class
      INTO DATA(ls_assigned_class)
      WITH KEY
        classinternalid = is_classification_data-classinternalid.

    ls_assigned_class-class_object->get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristic) ).

    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      DATA(ls_characteristic_header) = <ls_characteristic>-characteristic_object->get_header( ).

      IF ls_characteristic_header-entryisrequired = abap_true.
        READ TABLE lt_valuation_data
          TRANSPORTING NO FIELDS
          WITH KEY
            charcinternalid = <ls_characteristic>-charcinternalid.

        IF sy-subrc <> 0.
          APPEND ls_characteristic_header TO rt_incomplete_charact.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.