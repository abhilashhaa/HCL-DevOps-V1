  METHOD if_ngc_bil_clf~create_objcharcval.

    DATA:
      lt_create_by_charc TYPE if_ngc_bil_clf=>ts_objcharc-create_by-_objectcharcvalue-t_input.

    CLEAR: es_mapped, es_failed, es_reported.

    LOOP AT it_input INTO DATA(ls_input)
      GROUP BY (
        clfnobjectid     = ls_input-clfnobjectid
        clfnobjecttable  = ls_input-clfnobjecttable
        charcinternalid  = ls_input-charcinternalid
        classtype        = ls_input-classtype )
      REFERENCE INTO DATA(lr_create_group).

      APPEND INITIAL LINE TO lt_create_by_charc ASSIGNING FIELD-SYMBOL(<ls_input_by_charc>).
      <ls_input_by_charc>-clfnobjectid    = lr_create_group->clfnobjectid.
      <ls_input_by_charc>-clfnobjecttable = lr_create_group->clfnobjecttable.
      <ls_input_by_charc>-charcinternalid = lr_create_group->charcinternalid.
      <ls_input_by_charc>-classtype       = lr_create_group->classtype.

      LOOP AT GROUP lr_create_group ASSIGNING FIELD-SYMBOL(<ls_input>).
        APPEND INITIAL LINE TO <ls_input_by_charc>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        <ls_target> = CORRESPONDING #( <ls_input> ).
      ENDLOOP.
    ENDLOOP.

    me->if_ngc_bil_clf~create_objcharc_objcharcval(
      EXPORTING
        it_input    = lt_create_by_charc
      IMPORTING
        es_mapped   = es_mapped
        es_failed   = es_failed
        es_reported = es_reported ).

  ENDMETHOD.