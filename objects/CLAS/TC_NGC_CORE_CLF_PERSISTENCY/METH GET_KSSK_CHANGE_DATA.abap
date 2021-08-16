  METHOD get_kssk_change_data.

    LOOP AT it_kssk_change ASSIGNING FIELD-SYMBOL(<ls_kssk_change>).
      IF <ls_kssk_change>-object_state = if_ngc_c=>gc_object_state-deleted.
        APPEND INITIAL LINE TO et_kssk_delete_exp ASSIGNING FIELD-SYMBOL(<ls_kssk_delete_exp>).

        <ls_kssk_delete_exp>-objek = <ls_kssk_change>-object_key.
        <ls_kssk_delete_exp>-clint = <ls_kssk_change>-classinternalid.
        <ls_kssk_delete_exp>-obtab = <ls_kssk_change>-technical_object.
        <ls_kssk_delete_exp>-klart = <ls_kssk_change>-classtype.
        <ls_kssk_delete_exp>-mafid = <ls_kssk_change>-mafid.
        <ls_kssk_delete_exp>-cuobj = COND #(
          WHEN <ls_kssk_change>-object_key = <ls_kssk_change>-clfnobjectid
          THEN ''
          ELSE <ls_kssk_change>-clfnobjectid ).
      ELSE.
        APPEND INITIAL LINE TO et_kssk_insert_exp ASSIGNING FIELD-SYMBOL(<ls_kssk_insert_exp>).

        <ls_kssk_insert_exp>-objek = <ls_kssk_change>-object_key.
        <ls_kssk_insert_exp>-clint = <ls_kssk_change>-classinternalid.
        <ls_kssk_insert_exp>-klart = <ls_kssk_change>-classtype.
        <ls_kssk_insert_exp>-mafid = <ls_kssk_change>-mafid.
        <ls_kssk_insert_exp>-zaehl = <ls_kssk_change>-classpositionnumber.
        <ls_kssk_insert_exp>-statu = <ls_kssk_change>-clfnstatus.
        <ls_kssk_insert_exp>-datuv = <ls_kssk_change>-validitystartdate.
        <ls_kssk_insert_exp>-obtab = <ls_kssk_change>-technical_object.
        <ls_kssk_insert_exp>-vwstl = it_class_data[ classinternalid = <ls_kssk_change>-classinternalid ]-classisusableinbom.
        <ls_kssk_insert_exp>-cuobj = COND #(
          WHEN <ls_kssk_change>-object_key = <ls_kssk_change>-clfnobjectid
          THEN ''
          ELSE <ls_kssk_change>-clfnobjectid ).
        <ls_kssk_insert_exp>-class = it_class_data[ classinternalid = <ls_kssk_change>-classinternalid ]-class.

        CASE <ls_kssk_change>-object_state.
          WHEN if_ngc_c=>gc_object_state-created.
            <ls_kssk_insert_exp>-vbkz = 'I'.
          WHEN if_ngc_c=>gc_object_state-loaded.
            <ls_kssk_insert_exp>-vbkz = ''.
          WHEN if_ngc_c=>gc_object_state-updated.
            <ls_kssk_insert_exp>-vbkz = 'U'.
          WHEN OTHERS.
            cl_abap_unit_assert=>fail(
              msg = 'Invalid object state' ).
        ENDCASE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.