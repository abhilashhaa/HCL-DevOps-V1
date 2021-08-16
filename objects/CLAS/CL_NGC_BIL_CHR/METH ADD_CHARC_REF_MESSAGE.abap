  METHOD add_charc_ref_message.

    APPEND INITIAL LINE TO ct_reported ASSIGNING FIELD-SYMBOL(<ls_reported>).
    <ls_reported>-charcinternalid          = iv_charcinternalid.
    <ls_reported>-charcreferencetable      = iv_charc_ref_table.
    <ls_reported>-charcreferencetablefield = iv_charc_ref_field.
    <ls_reported>-%cid                     = iv_cid.

    IF is_bapiret IS INITIAL.
      DATA(ls_message) = CORRESPONDING symsg( sy ).
      <ls_reported>-%msg = mo_sy_message_convert->map_symsg_to_behv_message( ls_message ).
    ELSE.
      <ls_reported>-%msg = mo_bapi_message_convert->map_bapi_to_behv_message( is_bapiret ).
    ENDIF.

    IF iv_set_failed = abap_true.
      APPEND INITIAL LINE TO ct_failed ASSIGNING FIELD-SYMBOL(<ls_failed>).
      <ls_failed>-charcinternalid          = iv_charcinternalid.
      <ls_failed>-charcreferencetable      = iv_charc_ref_table.
      <ls_failed>-charcreferencetablefield = iv_charc_ref_field.
      <ls_failed>-%cid                     = iv_cid.

      IF iv_new = abap_true.
        DELETE mt_charc_change_data
          WHERE
            charc-charcinternalid = iv_root_charcinternalid.
      ENDIF.
    ENDIF.

  ENDMETHOD.