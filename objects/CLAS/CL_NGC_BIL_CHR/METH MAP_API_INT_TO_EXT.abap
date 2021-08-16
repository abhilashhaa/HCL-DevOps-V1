  METHOD map_api_int_to_ext.

    CLEAR: et_charc, et_charc_val_char, et_charc_val_curr, et_charc_val_num.


    APPEND INITIAL LINE TO et_charc ASSIGNING FIELD-SYMBOL(<ls_charc>).
    <ls_charc> = CORRESPONDING #( is_charc_data-charc ).

    LOOP AT is_charc_data-charcval ASSIGNING FIELD-SYMBOL(<ls_charc_val>).
      CASE is_charc_data-charc-data_type.
        WHEN if_ngc_c=>gc_charcdatatype-char.
          APPEND INITIAL LINE TO et_charc_val_char ASSIGNING FIELD-SYMBOL(<ls_charc_val_char>).
          <ls_charc_val_char> = CORRESPONDING #( <ls_charc_val> ).
        WHEN if_ngc_c=>gc_charcdatatype-curr.
          APPEND INITIAL LINE TO et_charc_val_curr ASSIGNING FIELD-SYMBOL(<ls_charc_val_curr>).
          <ls_charc_val_curr> = CORRESPONDING #( <ls_charc_val> ).
        WHEN if_ngc_c=>gc_charcdatatype-num OR if_ngc_c=>gc_charcdatatype-time OR if_ngc_c=>gc_charcdatatype-date.
          APPEND INITIAL LINE TO et_charc_val_num ASSIGNING FIELD-SYMBOL(<ls_charc_val_num>).
          <ls_charc_val_num> = CORRESPONDING #( <ls_charc_val> ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.