  METHOD get_class_from_objclass.

    DATA:
      lt_objclass TYPE if_ngc_bil_clf=>ts_objclass-create-t_input.

    LOOP AT it_obj_objclass ASSIGNING FIELD-SYMBOL(<ls_obj_objclass>).
      LOOP AT <ls_obj_objclass>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        APPEND INITIAL LINE TO lt_objclass ASSIGNING FIELD-SYMBOL(<ls_objclass>).
        <ls_objclass>-clfnobjectid    = <ls_obj_objclass>-clfnobjectid.
        <ls_objclass>-clfnobjecttable = <ls_obj_objclass>-clfnobjecttable.
        <ls_objclass>-classinternalid = <ls_target>-classinternalid.
        <ls_objclass>-classtype       = <ls_target>-classtype.
        <ls_objclass>-%cid            = <ls_target>-%cid.
      ENDLOOP.
    ENDLOOP.

    rt_objclass = lt_objclass.

  ENDMETHOD.