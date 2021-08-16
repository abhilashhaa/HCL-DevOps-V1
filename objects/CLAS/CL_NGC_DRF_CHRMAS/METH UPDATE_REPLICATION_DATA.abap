METHOD UPDATE_REPLICATION_DATA.

  IF iv_messagetype = if_ngc_drf_c=>gc_idoc_type_chrmas.
    LOOP AT it_idoc_result ASSIGNING FIELD-SYMBOL(<ls_idoc_control>).
      READ TABLE ct_obj_rep_sta ASSIGNING FIELD-SYMBOL(<ls_obj_rep>) WITH KEY object_id = iv_object_id.
      ASSERT sy-subrc = 0.
      <ls_obj_rep>-msg_link = <ls_idoc_control>-docnum.
    ENDLOOP.
  ENDIF.

ENDMETHOD.