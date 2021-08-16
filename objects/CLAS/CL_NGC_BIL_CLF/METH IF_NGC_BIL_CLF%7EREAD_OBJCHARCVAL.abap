  METHOD if_ngc_bil_clf~read_objcharcval.

    DATA:
      lt_charc_val_by_charc TYPE if_ngc_bil_clf=>ts_objcharc-read_by-_objectcharcvalue-t_input.

    CLEAR: et_result, es_failed, es_reported.

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY (
        clfnobjectid     = <ls_input>-clfnobjectid
        clfnobjecttable  = <ls_input>-clfnobjecttable
        charcinternalid  = <ls_input>-charcinternalid
        classtype        = <ls_input>-classtype )
      REFERENCE INTO DATA(lr_input_group).
      APPEND INITIAL LINE TO lt_charc_val_by_charc ASSIGNING FIELD-SYMBOL(<ls_charc_by_object>).
      <ls_charc_by_object>-clfnobjectid    = lr_input_group->clfnobjectid.
      <ls_charc_by_object>-clfnobjecttable = lr_input_group->clfnobjecttable.
      <ls_charc_by_object>-charcinternalid = lr_input_group->charcinternalid.
      <ls_charc_by_object>-classtype       = lr_input_group->classtype.
    ENDLOOP.

    me->if_ngc_bil_clf~read_objcharc_objcharcval(
      EXPORTING
        it_input    = lt_charc_val_by_charc
      IMPORTING
        et_result   = DATA(lt_charc_val) ).

    LOOP AT it_input ASSIGNING <ls_input>.
      DATA(ls_result) = VALUE #( lt_charc_val[
        charcinternalid          = <ls_input>-charcinternalid
        charcvaluepositionnumber = <ls_input>-charcvaluepositionnumber
        classtype                = <ls_input>-classtype
        clfnobjectid             = <ls_input>-clfnobjectid
        clfnobjecttable          = <ls_input>-clfnobjecttable ] OPTIONAL ).

      IF ls_result IS INITIAL.
        MESSAGE e051(ngc_rap) WITH <ls_input>-charcinternalid <ls_input>-charcvaluepositionnumber <ls_input>-clfnobjectid <ls_input>-clfnobjecttable INTO DATA(lv_msg) ##NEEDED.
        me->add_object_charc_val_msg(
          EXPORTING
            iv_cause                = if_abap_behv=>cause-not_found
            it_clfnobjectcharcval   = VALUE #(
              ( clfnobjectid             = <ls_input>-clfnobjectid
                clfnobjecttable          = <ls_input>-clfnobjecttable
                charcinternalid          = <ls_input>-charcinternalid
                charcvaluepositionnumber = <ls_input>-charcvaluepositionnumber
                classtype                = <ls_input>-classtype ) )
          CHANGING
            ct_reported             = es_reported
            ct_failed               = es_failed ).
      ELSE.
        APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
        <ls_result> = ls_result.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.