  METHOD add_class_message.

    DATA(ls_message) = CORRESPONDING symsg( sy ).

    APPEND INITIAL LINE TO ct_reported ASSIGNING FIELD-SYMBOL(<ls_reported>).
    <ls_reported>-classinternalid = iv_classinternalid.
    <ls_reported>-%cid            = iv_cid.
    <ls_reported>-%msg            = COND #(
      WHEN is_bapiret IS INITIAL
      THEN mo_sy_message_convert->map_symsg_to_behv_message( ls_message )
      ELSE mo_bapi_message_convert->map_bapi_to_behv_message( is_bapiret ) ).

    IF iv_set_failed = abap_true.
      APPEND INITIAL LINE TO ct_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
      <ls_failed>-classinternalid = iv_classinternalid.
      <ls_failed>-%cid            = iv_cid.
    ENDIF.

  ENDMETHOD.