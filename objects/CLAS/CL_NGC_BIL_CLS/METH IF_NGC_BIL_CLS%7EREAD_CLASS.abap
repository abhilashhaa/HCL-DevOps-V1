  METHOD if_ngc_bil_cls~read_class.

    CLEAR: et_class, et_failed.


    LOOP AT it_class ASSIGNING FIELD-SYMBOL(<ls_class>).
      me->read_class_data_by_id(
        EXPORTING
          iv_classinternalid = <ls_class>-classinternalid
        IMPORTING
          es_class           = DATA(ls_class)
      ).

      IF ls_class IS INITIAL.
        APPEND INITIAL LINE TO et_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-classinternalid = <ls_class>-classinternalid.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_class ASSIGNING FIELD-SYMBOL(<ls_class_out>).
      <ls_class_out> = CORRESPONDING #( ls_class ).
    ENDLOOP.

  ENDMETHOD.