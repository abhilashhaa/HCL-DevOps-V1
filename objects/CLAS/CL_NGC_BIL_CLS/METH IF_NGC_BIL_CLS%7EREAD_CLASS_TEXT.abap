  METHOD if_ngc_bil_cls~read_class_text.

    CLEAR: et_class_text, et_failed.


    LOOP AT it_class_text ASSIGNING FIELD-SYMBOL(<ls_class_text>).
      SELECT SINGLE * FROM i_clfnclasstextforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_class_text)
        WHERE
          classinternalid = @<ls_class_text>-classinternalid AND
          language        = @<ls_class_text>-language AND
          longtextid      = @<ls_class_text>-longtextid.

      IF ls_class_text IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-classinternalid = <ls_class_text>-classinternalid.
        <ls_failed>-language        = <ls_class_text>-language.
        <ls_failed>-longtextid      = <ls_class_text>-longtextid.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_class_text ASSIGNING FIELD-SYMBOL(<ls_class_text_out>).
      <ls_class_text_out> = CORRESPONDING #( ls_class_text ).
    ENDLOOP.

  ENDMETHOD.