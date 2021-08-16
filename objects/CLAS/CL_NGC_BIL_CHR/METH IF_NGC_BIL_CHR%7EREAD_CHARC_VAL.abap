  METHOD if_ngc_bil_chr~read_charc_val.

    CLEAR: et_charc_val.


    LOOP AT it_charc_val ASSIGNING FIELD-SYMBOL(<ls_charc_val>).
      SELECT SINGLE * FROM i_clfncharcvalforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_charc_val)
        WHERE
          charcinternalid          = @<ls_charc_val>-charcinternalid AND
          charcvaluepositionnumber = @<ls_charc_val>-charcvaluepositionnumber.

      IF ls_charc_val IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid          = <ls_charc_val>-charcinternalid.
        <ls_failed>-charcvaluepositionnumber = <ls_charc_val>-charcvaluepositionnumber.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc_val ASSIGNING FIELD-SYMBOL(<ls_charc_val_out>).
      <ls_charc_val_out> = CORRESPONDING #( ls_charc_val ).
    ENDLOOP.

  ENDMETHOD.