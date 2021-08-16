  METHOD get_charcval_from_charc.

    DATA:
      lt_objcharcval TYPE if_ngc_bil_clf=>ts_objcharcval-create-t_input.

    LOOP AT it_charc_objectcharcval ASSIGNING FIELD-SYMBOL(<ls_charc_objectcharcval>).
      LOOP AT <ls_charc_objectcharcval>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        APPEND INITIAL LINE TO lt_objcharcval ASSIGNING FIELD-SYMBOL(<ls_objcharcval>).
        <ls_objcharcval>-clfnobjectid             = <ls_charc_objectcharcval>-clfnobjectid.
        <ls_objcharcval>-clfnobjecttable          = <ls_charc_objectcharcval>-clfnobjecttable.
        <ls_objcharcval>-charcinternalid          = <ls_charc_objectcharcval>-charcinternalid.
        <ls_objcharcval>-classtype                = <ls_charc_objectcharcval>-classtype.
        <ls_objcharcval>-charcvaluepositionnumber = <ls_target>-charcvaluepositionnumber.
        <ls_objcharcval>-%cid                     = <ls_target>-%cid.
      ENDLOOP.
    ENDLOOP.

    rt_objectcharcval = lt_objcharcval.

  ENDMETHOD.