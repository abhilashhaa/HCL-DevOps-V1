  METHOD if_ngc_bil_clf~create_objclass.

    DATA:
      lt_create_by_object TYPE if_ngc_bil_clf=>ts_obj-create_by-_objectclass-t_input.

    CLEAR: es_mapped, es_failed, es_reported.

    LOOP AT it_input INTO DATA(ls_input)
      GROUP BY ( clfnobjectid     = ls_input-clfnobjectid
                 clfnobjecttable  = ls_input-clfnobjecttable )
      REFERENCE INTO DATA(lr_create_group).

      APPEND INITIAL LINE TO lt_create_by_object ASSIGNING FIELD-SYMBOL(<ls_input_by_object>).
      <ls_input_by_object>-clfnobjectid    = lr_create_group->clfnobjectid.
      <ls_input_by_object>-clfnobjecttable = lr_create_group->clfnobjecttable.

      LOOP AT GROUP lr_create_group ASSIGNING FIELD-SYMBOL(<ls_input>).
        APPEND INITIAL LINE TO <ls_input_by_object>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        <ls_target> = CORRESPONDING #( <ls_input> ).
      ENDLOOP.
    ENDLOOP.

    me->if_ngc_bil_clf~create_obj_objclass(
      EXPORTING
        it_input    = lt_create_by_object
      IMPORTING
        es_mapped   = es_mapped
        es_failed   = es_failed
        es_reported = es_reported ).

  ENDMETHOD.