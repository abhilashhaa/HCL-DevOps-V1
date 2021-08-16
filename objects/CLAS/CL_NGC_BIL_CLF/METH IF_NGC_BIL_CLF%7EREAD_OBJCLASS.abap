  METHOD if_ngc_bil_clf~read_objclass.

    DATA:
      lt_class_by_object TYPE if_ngc_bil_clf=>ts_obj-read_by-_objectclass-t_input.

    CLEAR: et_result, es_failed, es_reported.

    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<ls_input>)
      GROUP BY (
        clfnobjectid     = <ls_input>-clfnobjectid
        clfnobjecttable  = <ls_input>-clfnobjecttable )
      REFERENCE INTO DATA(lr_input_group).
      APPEND INITIAL LINE TO lt_class_by_object ASSIGNING FIELD-SYMBOL(<ls_class_by_object>).
      <ls_class_by_object>-clfnobjectid    = lr_input_group->clfnobjectid.
      <ls_class_by_object>-clfnobjecttable = lr_input_group->clfnobjecttable.
    ENDLOOP.

    me->if_ngc_bil_clf~read_obj_objclass(
      EXPORTING
        it_input    = lt_class_by_object
      IMPORTING
        et_result   = DATA(lt_class) ).

    LOOP AT it_input ASSIGNING <ls_input>.
      DATA(ls_result) = VALUE #( lt_class[
        classinternalid = <ls_input>-classinternalid
        clfnobjectid    = <ls_input>-clfnobjectid
        clfnobjecttable = <ls_input>-clfnobjecttable ] OPTIONAL ).

      IF ls_result IS INITIAL.
        MESSAGE e039(ngc_rap) WITH <ls_input>-classinternalid <ls_input>-clfnobjectid <ls_input>-clfnobjecttable INTO DATA(lv_msg) ##NEEDED.
        me->add_object_class_msg(
          EXPORTING
            iv_cause           = if_abap_behv=>cause-not_found
            it_clfnobjectclass = VALUE #(
              ( clfnobjectid    = <ls_input>-clfnobjectid
                clfnobjecttable = <ls_input>-clfnobjecttable
                classinternalid = <ls_input>-classinternalid ) )
          CHANGING
            ct_reported        = es_reported
            ct_failed          = es_failed ).
      ELSE.
        APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).
        <ls_result> = ls_result.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.