  METHOD if_ngc_bil_cls~read_class_desc.

    CLEAR: et_class_desc, et_failed.


    LOOP AT it_class_desc ASSIGNING FIELD-SYMBOL(<ls_class_desc>).
      SELECT SINGLE * FROM i_clfnclassdescforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_class_desc)
        WHERE
          classinternalid = @<ls_class_desc>-classinternalid AND
          language        = @<ls_class_desc>-language.

      IF ls_class_desc IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-classinternalid = <ls_class_desc>-classinternalid.
        <ls_failed>-language        = <ls_class_desc>-language.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_class_desc ASSIGNING FIELD-SYMBOL(<ls_class_desc_out>).
      <ls_class_desc_out> = CORRESPONDING #( ls_class_desc ).
    ENDLOOP.

  ENDMETHOD.