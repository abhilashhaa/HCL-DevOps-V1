  METHOD if_ngc_classification~get_assigned_classes.

    DATA: lv_state TYPE string.
    CLEAR: et_classification_data, et_assigned_class.

    lv_state = if_ngc_c=>gc_object_state-loaded && if_ngc_c=>gc_object_state-updated && if_ngc_c=>gc_object_state-created.

    IF et_classification_data IS REQUESTED.
      LOOP AT mt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>)
        WHERE object_state CA lv_state.
        READ TABLE mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class_upd>)
          WITH KEY classinternalid = <ls_classification_data_upd>-classinternalid.
        ASSERT sy-subrc = 0.
        DATA(ls_class_header) = <ls_assigned_class_upd>-class_object->get_header( ).

        APPEND VALUE #(
          classinternalid       = <ls_classification_data_upd>-classinternalid
          class                 = ls_class_header-class
          classtype             = ls_class_header-classtype
          clfnstatus            = <ls_classification_data_upd>-clfnstatus
          clfnstatusdescription = <ls_classification_data_upd>-clfnstatusdescription
          classpositionnumber   = <ls_classification_data_upd>-classpositionnumber
          classisstandardclass  = <ls_classification_data_upd>-classisstandardclass
          changenumber          = <ls_classification_data_upd>-changenumber
          lastchangedatetime    = <ls_classification_data_upd>-lastchangedatetime
        ) TO et_classification_data.

      ENDLOOP.
      SORT et_classification_data ASCENDING BY classtype classpositionnumber classinternalid.
    ENDIF.

    IF et_assigned_class IS REQUESTED.
      LOOP AT mt_assigned_class ASSIGNING <ls_assigned_class_upd>
        WHERE object_state CA lv_state.
        APPEND INITIAL LINE TO et_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class_exp>).
        MOVE-CORRESPONDING <ls_assigned_class_upd> TO <ls_assigned_class_exp>.
      ENDLOOP.
      SORT et_assigned_class ASCENDING BY classinternalid.
    ENDIF.

  ENDMETHOD.