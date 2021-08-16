  METHOD if_ngc_bil_chr~read_charc_val_desc.

    CLEAR: et_charc_val_desc.


    LOOP AT it_charc_val_desc ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc>).
      SELECT SINGLE * FROM i_clfncharcvaldescforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_charc_val_desc)
        WHERE
          charcinternalid          = @<ls_charc_val_desc>-charcinternalid AND
          charcvaluepositionnumber = @<ls_charc_val_desc>-charcvaluepositionnumber AND
          language                 = @<ls_charc_val_desc>-language.

      IF ls_charc_val_desc IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid          = <ls_charc_val_desc>-charcinternalid.
        <ls_failed>-charcvaluepositionnumber = <ls_charc_val_desc>-charcvaluepositionnumber.
        <ls_failed>-language                 = <ls_charc_val_desc>-language.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc_val_desc ASSIGNING FIELD-SYMBOL(<ls_charc_val_desc_out>).
      <ls_charc_val_desc_out> = CORRESPONDING #( ls_charc_val_desc ).
    ENDLOOP.

  ENDMETHOD.