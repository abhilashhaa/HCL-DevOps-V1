  METHOD if_ngc_core_clf_persistency~read_internal_object_number.

    LOOP AT it_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).

      APPEND INITIAL LINE TO rt_obj_int_id ASSIGNING FIELD-SYMBOL(<ls_obj_int_id>).

      <ls_obj_int_id>-classtype     = <ls_classtype>-classtype.
      <ls_obj_int_id>-clfnobjectid  = is_classification_key-object_key.

      DATA(ls_classtype) = if_ngc_core_clf_persistency~read_classtype(
                             iv_clfnobjecttable = is_classification_key-technical_object
                             iv_classtype       = <ls_classtype>-classtype
                           ).

      get_cuobj(
        EXPORTING
          is_classification_key = is_classification_key
          is_classtype          = ls_classtype
        IMPORTING
          ev_cuobj              = <ls_obj_int_id>-clfnobjectinternalid
*        ev_cuobj_is_new       =                  " Is EV_CUOBJ newly generated?
      ).

    ENDLOOP.

  ENDMETHOD.