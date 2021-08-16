  METHOD if_ngc_bil_chr~read_charc_desc.

    CLEAR: et_charc_desc.


    LOOP AT it_charc_desc ASSIGNING FIELD-SYMBOL(<ls_charc_desc>).
      SELECT SINGLE * FROM i_clfncharcdescforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_charc_desc)
        WHERE
          charcinternalid = @<ls_charc_desc>-charcinternalid AND
          language        = @<ls_charc_desc>-language.

      IF ls_charc_desc IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid = <ls_charc_desc>-charcinternalid.
        <ls_failed>-language        = <ls_charc_desc>-language.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc_desc ASSIGNING FIELD-SYMBOL(<ls_charc_desc_out>).
      <ls_charc_desc_out> = CORRESPONDING #( ls_charc_desc ).
    ENDLOOP.

  ENDMETHOD.