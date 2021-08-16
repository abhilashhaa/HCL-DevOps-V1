  METHOD fill_org_area.

    LOOP AT ct_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).

      READ TABLE mt_clfnclasshiercharc ASSIGNING FIELD-SYMBOL(<ls_clfnclasshiercharc>)
        WITH KEY classinternalid = <ls_class_characteristic>-classinternalid
                 charcinternalid = <ls_class_characteristic>-charcinternalid
                 key_date        = <ls_class_characteristic>-key_date.
      IF sy-subrc EQ 0.
        <ls_class_characteristic>-clfnorganizationalarea = <ls_clfnclasshiercharc>-clfnorganizationalarea.
        <ls_class_characteristic>-classtype              = <ls_clfnclasshiercharc>-classtype.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.