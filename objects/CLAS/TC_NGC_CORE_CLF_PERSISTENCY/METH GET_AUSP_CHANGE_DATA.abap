  METHOD get_ausp_change_data.

    LOOP AT it_ausp_change ASSIGNING FIELD-SYMBOL(<ls_ausp_change>).
      APPEND INITIAL LINE TO et_ausp_exp ASSIGNING FIELD-SYMBOL(<ls_ausp_exp>).

      <ls_ausp_exp>-objek = <ls_ausp_change>-object_key.
      <ls_ausp_exp>-obtab = <ls_ausp_change>-technical_object.
      <ls_ausp_exp>-atinn = <ls_ausp_change>-charcinternalid.
      <ls_ausp_exp>-atzhl = <ls_ausp_change>-charcvaluepositionnumber.
      <ls_ausp_exp>-klart = <ls_ausp_change>-classtype.
      <ls_ausp_exp>-mafid = <ls_ausp_change>-clfnobjecttype.
      <ls_ausp_exp>-atwrt = <ls_ausp_change>-charcvalue.
      <ls_ausp_exp>-atcod = <ls_ausp_change>-charcvaluedependency.
      <ls_ausp_exp>-atflv = <ls_ausp_change>-charcfromnumericvalue.
      <ls_ausp_exp>-atawe = <ls_ausp_change>-charcfromnumericvalueunit.
      <ls_ausp_exp>-datuv = <ls_ausp_change>-validitystartdate.
      <ls_ausp_exp>-cuobj = COND #(
        WHEN <ls_ausp_change>-object_key = <ls_ausp_change>-clfnobjectid
        THEN ''
        ELSE <ls_ausp_change>-clfnobjectid ).

      CASE <ls_ausp_change>-object_state.
        WHEN if_ngc_c=>gc_object_state-created.
          <ls_ausp_exp>-statu = 'H'.
        WHEN if_ngc_c=>gc_object_state-updated.
          <ls_ausp_exp>-statu = 'V'.
        WHEN if_ngc_c=>gc_object_state-deleted.
          <ls_ausp_exp>-statu = 'L'.
        WHEN if_ngc_c=>gc_object_state-loaded.
        WHEN OTHERS.
          cl_abap_unit_assert=>fail(
            msg = 'Invalid object state' ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.