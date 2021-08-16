  METHOD if_ngc_bil_chr~read_charc_ref.

    CLEAR: et_charc_ref.


    LOOP AT it_charc_ref ASSIGNING FIELD-SYMBOL(<ls_charc_ref>).
      SELECT SINGLE * FROM i_clfncharcrefforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_charc_ref)
        WHERE
          charcinternalid          = @<ls_charc_ref>-charcinternalid AND
          charcreferencetable      = @<ls_charc_ref>-charcreferencetable AND
          charcreferencetablefield = @<ls_charc_ref>-charcreferencetablefield.

      IF ls_charc_ref IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid          = <ls_charc_ref>-charcinternalid.
        <ls_failed>-charcreferencetable      = <ls_charc_ref>-charcreferencetable.
        <ls_failed>-charcreferencetablefield = <ls_charc_ref>-charcreferencetablefield.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc_ref ASSIGNING FIELD-SYMBOL(<ls_charc_ref_out>).
      <ls_charc_ref_out> = CORRESPONDING #( ls_charc_ref ).
    ENDLOOP.

  ENDMETHOD.