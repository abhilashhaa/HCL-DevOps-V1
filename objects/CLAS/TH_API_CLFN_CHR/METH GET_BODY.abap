  METHOD get_body.

    DATA: lv_attribute_value  TYPE string,
          lv_attribute_string TYPE string,
          lv_fieldname_string TYPE string,
          lv_count            TYPE i.
    DATA: lv_first_field      TYPE boole_d VALUE abap_true.

    FIELD-SYMBOLS: <lg_attribute_value> TYPE any.

    CLEAR rv_body.

    rv_body = '{'.

    LOOP AT it_charcdesc_fieldname ASSIGNING FIELD-SYMBOL(<ls_fieldname>).
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_charcdesc TO <lg_attribute_value>.
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

    LOOP AT it_charcref_fieldname ASSIGNING <ls_fieldname>.
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_charcref TO <lg_attribute_value>.
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

    LOOP AT it_charcrstrcn_fieldname ASSIGNING <ls_fieldname>.
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_charcrstrcn TO <lg_attribute_value>.
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

    LOOP AT it_charcvalue_fieldname ASSIGNING <ls_fieldname>.
      ASSIGN COMPONENT <ls_fieldname> OF STRUCTURE is_charcvalue TO <lg_attribute_value>.
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

    CONCATENATE rv_body '}' INTO rv_body SEPARATED BY space.

  ENDMETHOD.