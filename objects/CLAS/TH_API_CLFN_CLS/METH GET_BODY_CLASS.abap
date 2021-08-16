  METHOD get_body_class.

    DATA: lv_attribute_string TYPE string,
          lv_fieldname_string TYPE string,
          lv_count            TYPE i.
    DATA: lv_first_field      TYPE boole_d VALUE abap_true.

    FIELD-SYMBOLS: <lg_attribute_value> TYPE any.

    CLEAR rv_body.

    rv_body = '{'.

    LOOP AT it_class_fieldname ASSIGNING FIELD-SYMBOL(<ls_fieldname>).
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_class TO <lg_attribute_value>.
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

    IF it_classdesc IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_classdesc ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_ClassDescription" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_classdesc ASSIGNING FIELD-SYMBOL(<ls_classdesc>).
        LOOP AT it_classdesc_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_classdesc> TO <lg_attribute_value>.
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

    IF it_classkeyword IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_classkeyword ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_ClassKeyword" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_classkeyword ASSIGNING FIELD-SYMBOL(<ls_classkeyword>).
        LOOP AT it_classkeyword_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_classkeyword> TO <lg_attribute_value>.
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

    IF it_classtext IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_classtext ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_ClassText" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_classtext ASSIGNING FIELD-SYMBOL(<ls_classtext>).
        LOOP AT it_classtext_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_classtext> TO <lg_attribute_value>.
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

    IF it_classcharc IS NOT INITIAL.
      lv_first_field = abap_true.
      lv_count = lines( it_classcharc ).
      rv_body = rv_body && ','.
      CONCATENATE rv_body '"to_ClassCharacteristic" : [' INTO rv_body SEPARATED BY space.
      CONCATENATE rv_body '{' INTO rv_body SEPARATED BY space.
      LOOP AT it_classcharc ASSIGNING FIELD-SYMBOL(<ls_classcharc>).
        LOOP AT it_classcharc_fieldname ASSIGNING <ls_fieldname>.
          ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_classcharc> TO <lg_attribute_value>.
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

    CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.

  ENDMETHOD.