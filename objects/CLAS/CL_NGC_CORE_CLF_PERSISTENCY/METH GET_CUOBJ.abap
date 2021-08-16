  METHOD get_cuobj.

    " in case INOB entry is needed, we need to
    " read (by class type) and use the already existing one
    " or generate a new one

    CLEAR: ev_cuobj, ev_cuobj_is_new.

    IF is_classtype-multipleobjtableclfnisallowed = abap_false.
      RETURN.
    ENDIF.

    " Assumption: entries from INOB were already loaded.
    " Here we consider deleted entries as well.
    " An INOB entry, which was loaded and deleted, can be reactivated.
    " Object key is also part of the keys.
    " Therefore we return the CUOBJ of the deleted INOB entry as well.
    READ TABLE mt_inob_changes ASSIGNING FIELD-SYMBOL(<ls_inob_change>)
      WITH KEY technical_object =  is_classification_key-technical_object
               object_key       =  is_classification_key-object_key
               change_number    =  is_classification_key-change_number
               key_date         =  is_classification_key-key_date
               classtype        =  is_classtype-classtype.

    " if CUOBJ cannot be found in the INOB table, it is considered as new
    ev_cuobj_is_new = boolc( sy-subrc <> 0 ).

    IF ev_cuobj_is_new = abap_true.

      " in case of new CUOBJ try to get it from the buffer at first
      READ TABLE mt_inob_new ASSIGNING FIELD-SYMBOL(<ls_inob_new>)
        WITH KEY technical_object =  is_classification_key-technical_object
                 object_key       =  is_classification_key-object_key
                 change_number    =  is_classification_key-change_number
                 key_date         =  is_classification_key-key_date
                 classtype        =  is_classtype-classtype.

      IF sy-subrc = 0.
        ev_cuobj = <ls_inob_new>-clfnobjectinternalid.
      ELSE.

        " in case of new CUOBJ is not found in the buffer, a new one shall be generated from number range
        ev_cuobj = mo_util->get_next_cuobj_from_nr( ).

        " the newly generated CUOBJ is stored in buffer
        APPEND INITIAL LINE TO mt_inob_new ASSIGNING <ls_inob_new>.
        <ls_inob_new>-clfnobjectinternalid  = ev_cuobj.
        <ls_inob_new>-technical_object      = is_classification_key-technical_object.
        <ls_inob_new>-object_key            = is_classification_key-object_key.
        <ls_inob_new>-change_number         = is_classification_key-change_number.
        <ls_inob_new>-key_date              = is_classification_key-key_date.
        <ls_inob_new>-classtype             = is_classtype-classtype.

      ENDIF.

    ELSE.
      ev_cuobj = <ls_inob_change>-clfnobjectinternalid.
    ENDIF.

  ENDMETHOD.