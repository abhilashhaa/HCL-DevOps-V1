  METHOD get_body.

    DATA: lv_attribute_string TYPE string,
          lv_fieldname_string TYPE string.
    DATA: lv_first_field      TYPE boole_d VALUE abap_true.
    FIELD-SYMBOLS: <lt_content> TYPE STANDARD TABLE.
    FIELD-SYMBOLS: <lg_attribute_value> TYPE any.

    CLEAR rv_body.

    IF it_classdesc IS SUPPLIED.
      ASSIGN it_classdesc TO <lt_content>.
    ELSEIF it_classkeyword IS SUPPLIED.
      ASSIGN it_classkeyword TO <lt_content>.
    ELSEIF it_classtext IS SUPPLIED.
      ASSIGN it_classtext TO <lt_content>.
    ELSEIF it_classcharc IS SUPPLIED.
      ASSIGN it_classcharc TO <lt_content>.
    ENDIF.

    ASSERT <lt_content> IS NOT INITIAL.

    rv_body = '{'.
    LOOP AT <lt_content> ASSIGNING FIELD-SYMBOL(<ls_content>).
      LOOP AT it_fieldname ASSIGNING FIELD-SYMBOL(<ls_fieldname>).
        ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE <ls_content> TO <lg_attribute_value>.
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
    ENDLOOP.
    CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.

  ENDMETHOD.