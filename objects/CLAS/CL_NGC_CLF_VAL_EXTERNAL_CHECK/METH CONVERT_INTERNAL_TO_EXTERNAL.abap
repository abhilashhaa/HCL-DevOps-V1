  METHOD convert_internal_to_external.

    DATA:
      lv_function_name TYPE rs38l_fnam VALUE 'CONVERSION_EXIT_$_OUTPUT',
      lv_char_255(255) type c,
      lr_reference TYPE REF TO data.

    IF is_characteristic-charcreferencetable IS NOT INITIAL AND
       is_characteristic-charcreferencetablefield IS NOT INITIAL AND
       iv_class_type IS NOT INITIAL.
      CREATE DATA lr_reference TYPE (is_characteristic-charcreferencetable).
      ASSIGN lr_reference->* TO FIELD-SYMBOL(<ls_structure>).

      ASSIGN COMPONENT is_characteristic-charcreferencetablefield
        OF STRUCTURE <ls_structure>
        TO FIELD-SYMBOL(<lv_name>).

      CHECK sy-subrc IS INITIAL.
    ELSEIF is_characteristic-charcchecktable IS NOT INITIAL AND
           iv_class_type IS NOT INITIAL.
      ASSIGN iv_assigned_value TO <lv_name>.
    ELSE.
      EXIT.
    ENDIF.

    ASSIGN iv_assigned_value TO <lv_name>.

    REPLACE '$' WITH iv_convexit INTO lv_function_name.
    CONDENSE lv_function_name NO-GAPS.

    CALL FUNCTION lv_function_name
      EXPORTING
        input  = <lv_name>
      IMPORTING
        output = lv_char_255.

    DESCRIBE FIELD iv_assigned_value LENGTH DATA(lv_length) IN CHARACTER MODE.

    IF strlen( lv_char_255 ) <= lv_length.
      ev_new_value = lv_char_255.
    ELSE.
      ev_new_value = <lv_name>.
    ENDIF.

  ENDMETHOD.