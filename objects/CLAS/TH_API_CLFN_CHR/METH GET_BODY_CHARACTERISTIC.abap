  METHOD get_body_characteristic.

    DATA: lv_attribute_value  TYPE string,
          lv_attribute_string TYPE string,
          lv_fieldname_string TYPE string,
          lv_count            TYPE i.
    DATA: lv_first_field      TYPE boole_d VALUE abap_true.

    FIELD-SYMBOLS: <lg_attribute_value> TYPE any.

    CLEAR rv_body.

    rv_body = '{'.

    LOOP AT it_charc_fieldname ASSIGNING FIELD-SYMBOL(<ls_fieldname>).
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_charc TO <lg_attribute_value>.
      IF sy-subrc NE 0.
        CONTINUE.
      ENDIF.

      lv_fieldname_string = '"' && <ls_fieldname> && '"'.

      IF <ls_fieldname> = 'CharcLength' OR <ls_fieldname> = 'CharcDecimals' .
        lv_attribute_string = <lg_attribute_value>.
      ELSEIF <ls_fieldname> = 'CharcHasSingleValue'.
        lv_attribute_string = COND #( WHEN <lg_attribute_value> = abap_true THEN 'true' ELSE 'false' ).
      ELSE.
        lv_attribute_string = '"' && <lg_attribute_value> && '"'.
      ENDIF.

      IF lv_first_field EQ abap_true.
        CONCATENATE
          rv_body
          lv_fieldname_string
          ':'
          lv_attribute_string
        INTO rv_body
        SEPARATED BY space.
        lv_first_field = abap_false.
      ELSE.
        CONCATENATE
          rv_body
          ','
          lv_fieldname_string
          ':'
          lv_attribute_string
        INTO rv_body
        SEPARATED BY space.
      ENDIF.
    ENDLOOP.

    IF it_charcdesc IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_charcdesc ).
      lv_count = lines( it_charcdesc ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_CharacteristicDesc" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_charcdesc ASSIGNING FIELD-SYMBOL(<ls_charcdesc>).
        LOOP AT it_charcdesc_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_charcdesc> TO <lg_attribute_value>.
          IF sy-subrc NE 0.
            CONTINUE.
          ENDIF.

          lv_fieldname_string = '"' && <ls_fieldname> && '"'.
          lv_attribute_string = '"' && <lg_attribute_value> && '"'.

          IF lv_first_field EQ abap_true.
            CONCATENATE
              rv_body
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
            lv_first_field = abap_false.
          ELSE.
            CONCATENATE
              rv_body
              ','
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        IF sy-tabix LT lv_count.
          CONCATENATE
            rv_body
            '}'
            ','
            '{'
          INTO rv_body
          SEPARATED BY space.
          lv_first_field = abap_true.
        ENDIF.
      ENDLOOP.
      CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body ']' INTO rv_body SEPARATED BY space.
    ENDIF.

    IF it_charcref IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_charcref ).
      lv_count = lines( it_charcref ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_CharacteristicReference" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_charcref ASSIGNING FIELD-SYMBOL(<ls_charcref>).
        LOOP AT it_charcref_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_charcref> TO <lg_attribute_value>.
          IF sy-subrc NE 0.
            CONTINUE.
          ENDIF.

          lv_fieldname_string = '"' && <ls_fieldname> && '"'.
          lv_attribute_string = '"' && <lg_attribute_value> && '"'.

          IF lv_first_field EQ abap_true.
            CONCATENATE
              rv_body
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
            lv_first_field = abap_false.
          ELSE.
            CONCATENATE
              rv_body
              ','
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        IF sy-tabix LT lv_count.
          CONCATENATE
            rv_body
            '}'
            ','
            '{'
          INTO rv_body
          SEPARATED BY space.
          lv_first_field = abap_true.
        ENDIF.
      ENDLOOP.
      CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body ']' INTO rv_body SEPARATED BY space.
    ENDIF.

    IF it_charcrstrcn IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_charcrstrcn ).
      lv_count = lines( it_charcrstrcn ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_CharacteristicRestriction" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_charcrstrcn ASSIGNING FIELD-SYMBOL(<ls_charcrstrcn>).
        LOOP AT it_charcrstrcn_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_charcrstrcn> TO <lg_attribute_value>.
          IF sy-subrc NE 0.
            CONTINUE.
          ENDIF.

          lv_fieldname_string = '"' && <ls_fieldname> && '"'.
          lv_attribute_string = '"' && <lg_attribute_value> && '"'.

          IF lv_first_field EQ abap_true.
            CONCATENATE
              rv_body
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
            lv_first_field = abap_false.
          ELSE.
            CONCATENATE
              rv_body
              ','
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        IF sy-tabix LT lv_count.
          CONCATENATE
            rv_body
            '}'
            ','
            '{'
          INTO rv_body
          SEPARATED BY space.
          lv_first_field = abap_true.
        ENDIF.
      ENDLOOP.
      CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body ']' INTO rv_body SEPARATED BY space.
    ENDIF.

    IF it_charcvalue IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_charcvalue ).
      lv_count = lines( it_charcvalue ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_CharacteristicValue" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_charcvalue ASSIGNING FIELD-SYMBOL(<ls_charcvalue>).
        LOOP AT it_charcvalue_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_charcvalue> TO <lg_attribute_value>.
          IF sy-subrc NE 0.
            CONTINUE.
          ENDIF.


          lv_fieldname_string = '"' && <ls_fieldname> && '"'.

          IF <ls_fieldname> = 'CharcFromNumericValue' OR <ls_fieldname> = 'CharcToNumericValue' .
            lv_attribute_string = <lg_attribute_value>.
          ELSEIF <ls_fieldname> = 'IsDefaultValue'.
            lv_attribute_string = COND #( WHEN <lg_attribute_value> = abap_true THEN 'true' ELSE 'false' ).
          ELSE.
            lv_attribute_string = '"' && <lg_attribute_value> && '"'.
          ENDIF.

          IF lv_first_field EQ abap_true.
            CONCATENATE
              rv_body
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
            lv_first_field = abap_false.
          ELSE.
            CONCATENATE
              rv_body
              ','
              lv_fieldname_string
              ':'
              lv_attribute_string
            INTO rv_body
            SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        IF sy-tabix LT lv_count.
          CONCATENATE
            rv_body
            '}'
            ','
            '{'
          INTO rv_body
          SEPARATED BY space.
          lv_first_field = abap_true.
        ENDIF.
      ENDLOOP.
      CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body ']' INTO rv_body SEPARATED BY space.
    ENDIF.

    CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.

  ENDMETHOD.