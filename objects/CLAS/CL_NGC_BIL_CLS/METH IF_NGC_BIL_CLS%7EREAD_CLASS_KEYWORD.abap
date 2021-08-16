  METHOD if_ngc_bil_cls~read_class_keyword.

    CLEAR: et_class_keyword, et_failed.


    LOOP AT it_class_keyword ASSIGNING FIELD-SYMBOL(<ls_class_keyword>).
      SELECT SINGLE * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_class_keyword)
        WHERE
          classinternalid            = @<ls_class_keyword>-classinternalid AND
          language                   = @<ls_class_keyword>-language AND
          classkeywordpositionnumber = @<ls_class_keyword>-classkeywordpositionnumber.

      IF ls_class_keyword IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-classinternalid            = <ls_class_keyword>-classinternalid.
        <ls_failed>-language                   = <ls_class_keyword>-language.
        <ls_failed>-classkeywordpositionnumber = <ls_class_keyword>-classkeywordpositionnumber.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_class_keyword ASSIGNING FIELD-SYMBOL(<ls_class_keyword_out>).
      <ls_class_keyword_out> = CORRESPONDING #( ls_class_keyword ).
    ENDLOOP.

  ENDMETHOD.