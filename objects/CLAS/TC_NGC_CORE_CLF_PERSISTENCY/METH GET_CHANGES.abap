  METHOD get_changes.

    LOOP AT it_change_data ASSIGNING FIELD-SYMBOL(<ls_change_data>).
      LOOP AT <ls_change_data>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
        APPEND INITIAL LINE TO et_kssk_change ASSIGNING FIELD-SYMBOL(<ls_kssk_change>).
        MOVE-CORRESPONDING <ls_classification_data> TO <ls_kssk_change>.
        MOVE-CORRESPONDING <ls_change_data> TO <ls_kssk_change>.
        <ls_kssk_change>-clfnobjectid    = <ls_change_data>-object_key.
        <ls_kssk_change>-mafid           = 'O'.
        <ls_kssk_change>-validityenddate = '99991231'.
        <ls_kssk_change>-classtype       = it_class[ classinternalid = <ls_classification_data>-classinternalid ]-classtype.

        DATA(ls_kssk) = VALUE #( it_kssk_data[
          technical_object = <ls_change_data>-technical_object
          object_key       = <ls_change_data>-object_key
          key_date         = <ls_change_data>-key_date
          classtype        = <ls_kssk_change>-classtype
          classinternalid  = <ls_kssk_change>-classinternalid ] OPTIONAL ).

        IF ls_kssk IS NOT INITIAL.
          IF ls_kssk-object_state = if_ngc_c=>gc_object_state-deleted AND
             <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-created.
            <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-updated.
          ELSEIF ls_kssk-object_state = if_ngc_c=>gc_object_state-updated AND
                 <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-created.
            <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-updated.
          ELSEIF ls_kssk-object_state = if_ngc_c=>gc_object_state-created AND
                 <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-updated.
            <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-created.
          ENDIF.
        ENDIF.

        DATA(ls_classtype) = VALUE #( it_classtype[ classtype = <ls_kssk_change>-classtype clfnobjecttable = <ls_change_data>-technical_object ] ).

        IF ls_classtype-multipleobjtableclfnisallowed = abap_true.
          DATA(ls_inob) = VALUE #( it_inob_data[
            technical_object = <ls_change_data>-technical_object
            object_key       = <ls_change_data>-object_key
            key_date         = <ls_change_data>-key_date
            classtype        = <ls_kssk_change>-classtype ] OPTIONAL ).

          IF ls_inob IS INITIAL.
            <ls_kssk_change>-clfnobjectid = th_ngc_core_clf_pers_data=>cv_object_intkey_03.
          ELSE.
            <ls_kssk_change>-clfnobjectid = ls_inob-clfnobjectinternalid.
          ENDIF.
        ENDIF.
      ENDLOOP.

      LOOP AT it_kssk_data ASSIGNING FIELD-SYMBOL(<ls_kssk_data>).
        IF NOT line_exists( et_kssk_change[
          technical_object = <ls_kssk_data>-technical_object
          object_key       = <ls_kssk_data>-object_key
          key_date         = <ls_kssk_data>-key_date
          classtype        = <ls_kssk_data>-classtype
          classinternalid  = <ls_kssk_data>-classinternalid ] ).
          APPEND <ls_kssk_data> TO et_kssk_change.
        ENDIF.
      ENDLOOP.

      LOOP AT <ls_change_data>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
        APPEND INITIAL LINE TO et_ausp_change ASSIGNING FIELD-SYMBOL(<ls_ausp_change>).
        MOVE-CORRESPONDING <ls_valuation_data> TO <ls_ausp_change>.
        MOVE-CORRESPONDING <ls_change_data> TO <ls_ausp_change>.

        DATA(ls_ausp) = VALUE #( it_ausp_data[
            technical_object         = <ls_change_data>-technical_object
            object_key               = <ls_change_data>-object_key
            key_date                 = <ls_change_data>-key_date
            classtype                = <ls_valuation_data>-classtype
            charcvaluepositionnumber = <ls_valuation_data>-charcvaluepositionnumber ] OPTIONAL ).

        IF ls_ausp IS NOT INITIAL.
          IF ls_ausp-object_state = if_ngc_c=>gc_object_state-deleted AND
             <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-created.
            <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-updated.
          ELSEIF ls_ausp-object_state = if_ngc_c=>gc_object_state-updated AND
                 <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-created.
            <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-updated.
          ELSEIF ls_ausp-object_state = if_ngc_c=>gc_object_state-created AND
                 <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-updated.
            <ls_ausp_change>-object_state = if_ngc_c=>gc_object_state-created.
          ENDIF.
        ENDIF.

        ls_classtype = VALUE #( it_classtype[ classtype = <ls_ausp_change>-classtype clfnobjecttable = <ls_change_data>-technical_object ] ).

        IF ls_classtype-multipleobjtableclfnisallowed = abap_true.
          ls_inob = VALUE #( it_inob_data[
            technical_object = <ls_change_data>-technical_object
            object_key       = <ls_change_data>-object_key
            key_date         = <ls_change_data>-key_date
            classtype        = <ls_ausp_change>-classtype ] OPTIONAL ).

          IF ls_inob IS INITIAL.
            <ls_ausp_change>-clfnobjectid = th_ngc_core_clf_pers_data=>cv_object_intkey_03.
          ELSE.
            <ls_ausp_change>-clfnobjectid = ls_inob-clfnobjectinternalid.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT it_ausp_data ASSIGNING FIELD-SYMBOL(<ls_ausp_data>).
      IF NOT line_exists( et_ausp_change[
        technical_object         = <ls_ausp_data>-technical_object
        object_key               = <ls_ausp_data>-object_key
        key_date                 = <ls_ausp_data>-key_date
        classtype                = <ls_ausp_data>-classtype
        charcvaluepositionnumber = <ls_ausp_data>-charcvaluepositionnumber ] ).
        APPEND <ls_ausp_data> TO et_ausp_change.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.