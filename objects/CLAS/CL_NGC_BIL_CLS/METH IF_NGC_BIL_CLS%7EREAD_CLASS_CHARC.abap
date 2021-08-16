  METHOD if_ngc_bil_cls~read_class_charc.

    CLEAR: et_class_charc, et_failed.


    LOOP AT it_class_charc ASSIGNING FIELD-SYMBOL(<ls_class_charc>).
      SELECT SINGLE * FROM i_clfnclasscharcforkeydatetp( p_keydate = @sy-datum )
        INTO @DATA(ls_class_charc)
        WHERE
          classinternalid = @<ls_class_charc>-classinternalid AND
          charcinternalid = @<ls_class_charc>-charcinternalid.

      IF ls_class_charc IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-classinternalid = <ls_class_charc>-classinternalid.
        <ls_failed>-charcinternalid = <ls_class_charc>-charcinternalid.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_class_charc ASSIGNING FIELD-SYMBOL(<ls_class_charc_out>).
      <ls_class_charc_out> = CORRESPONDING #( ls_class_charc ).
    ENDLOOP.

  ENDMETHOD.