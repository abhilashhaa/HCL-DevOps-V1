  METHOD add_exception_to_object_msg.

    DATA(lo_msg_collector) = cf_reca_message_list=>create( ).

    lo_msg_collector->add_from_exception(
      EXPORTING
        io_exception = io_exception ).

    lo_msg_collector->get_list_as_bapiret(
      IMPORTING
        et_list = DATA(lt_bapiret) ).

    LOOP AT lt_bapiret ASSIGNING FIELD-SYMBOL(<ls_bapiret>).
      DATA(ls_symsg) = VALUE symsg( msgid = <ls_bapiret>-id
                                    msgno = <ls_bapiret>-number
                                    msgty = <ls_bapiret>-type
                                    msgv1 = <ls_bapiret>-message_v1
                                    msgv2 = <ls_bapiret>-message_v2
                                    msgv3 = <ls_bapiret>-message_v3
                                    msgv4 = <ls_bapiret>-message_v4 ).

      APPEND INITIAL LINE TO ct_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported>).
      <ls_reported>-%cid            = is_clfnobject-cid.
      <ls_reported>-clfnobjectid    = is_clfnobject-clfnobjectid.
      <ls_reported>-clfnobjecttable = is_clfnobject-clfnobjecttable.
      <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

      IF ls_symsg-msgty CA gc_error_codes.
        APPEND INITIAL LINE TO ct_failed-object ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-%cid            = is_clfnobject-cid.
        <ls_failed>-clfnobjectid    = is_clfnobject-clfnobjectid.
        <ls_failed>-clfnobjecttable = is_clfnobject-clfnobjecttable.
        <ls_failed>-%fail-cause     = iv_cause.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.