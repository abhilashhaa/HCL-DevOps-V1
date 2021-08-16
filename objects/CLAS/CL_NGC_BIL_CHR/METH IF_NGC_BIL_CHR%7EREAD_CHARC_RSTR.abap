  METHOD if_ngc_bil_chr~read_charc_rstr.

    CLEAR: et_charc_rstr.


    LOOP AT it_charc_rstr ASSIGNING FIELD-SYMBOL(<ls_charc_rstr>).
      SELECT SINGLE * FROM i_clfncharcrstrcnforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_charc_rstr)
        WHERE
          charcinternalid = @<ls_charc_rstr>-charcinternalid AND
          classtype       = @<ls_charc_rstr>-classtype.

      IF ls_charc_rstr IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid = <ls_charc_rstr>-charcinternalid.
        <ls_failed>-classtype       = <ls_charc_rstr>-classtype.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc_rstr ASSIGNING FIELD-SYMBOL(<ls_charc_rstr_out>).
      <ls_charc_rstr_out> = CORRESPONDING #( ls_charc_rstr ).
    ENDLOOP.

  ENDMETHOD.