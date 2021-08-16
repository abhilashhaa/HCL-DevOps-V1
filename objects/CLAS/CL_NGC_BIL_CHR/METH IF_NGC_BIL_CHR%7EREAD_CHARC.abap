  METHOD if_ngc_bil_chr~read_charc.

    CLEAR: et_charc.


    LOOP AT it_charc ASSIGNING FIELD-SYMBOL(<ls_charc>).
      me->read_characteristic_data_by_id(
        EXPORTING
          iv_charcinternalid = <ls_charc>-charcinternalid
        IMPORTING
          es_characteristic  = DATA(ls_charc) ).

      IF ls_charc IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-charcinternalid = <ls_charc>-charcinternalid.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_charc ASSIGNING FIELD-SYMBOL(<ls_charc_out>).
      <ls_charc_out> = CORRESPONDING #( ls_charc ).
    ENDLOOP.

  ENDMETHOD.