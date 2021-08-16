  METHOD get_inob_change_data.

    LOOP AT it_inob_change ASSIGNING FIELD-SYMBOL(<ls_inob_change>).
      IF <ls_inob_change>-object_state = if_ngc_c=>gc_object_state-deleted.
        APPEND INITIAL LINE TO et_inob_delete_exp ASSIGNING FIELD-SYMBOL(<ls_inob_delete_exp>).

        <ls_inob_delete_exp>-cuobj = <ls_inob_change>-clfnobjectinternalid.
      ELSE.
        APPEND INITIAL LINE TO et_inob_insert_exp ASSIGNING FIELD-SYMBOL(<ls_inob_insert_exp>).

        <ls_inob_insert_exp>-mandt = sy-mandt.
        <ls_inob_insert_exp>-cuobj = <ls_inob_change>-clfnobjectinternalid.
        <ls_inob_insert_exp>-objek = <ls_inob_change>-clfnobjectid.
        <ls_inob_insert_exp>-klart = <ls_inob_change>-classtype.
        <ls_inob_insert_exp>-obtab = <ls_inob_change>-clfnobjecttable.
        <ls_inob_insert_exp>-clint = <ls_inob_change>-clint.
        <ls_inob_insert_exp>-statu = <ls_inob_change>-statu.
        <ls_inob_insert_exp>-datuv = <ls_inob_change>-datuv.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.