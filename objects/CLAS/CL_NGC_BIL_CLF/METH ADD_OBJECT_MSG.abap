  METHOD add_object_msg.

    IF io_ngc_api_result IS NOT SUPPLIED.
      DATA(ls_symsg) = CORRESPONDING symsg( sy ).

      LOOP AT it_clfnobject ASSIGNING FIELD-SYMBOL(<ls_clfnobject>).
        APPEND INITIAL LINE TO ct_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported>).
        <ls_reported>-%cid            = <ls_clfnobject>-cid.
        <ls_reported>-clfnobjectid    = <ls_clfnobject>-clfnobjectid.
        <ls_reported>-clfnobjecttable = <ls_clfnobject>-clfnobjecttable.
        <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO ct_failed-object ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%cid            = <ls_clfnobject>-cid.
          <ls_failed>-clfnobjectid    = <ls_clfnobject>-clfnobjectid.
          <ls_failed>-clfnobjecttable = <ls_clfnobject>-clfnobjecttable.
          <ls_failed>-%fail-cause     = iv_cause.
        ENDIF.
      ENDLOOP.
    ELSEIF io_ngc_api_result IS NOT INITIAL.
      DATA(lt_ngc_api_msg) = io_ngc_api_result->get_messages( ).

      LOOP AT lt_ngc_api_msg ASSIGNING FIELD-SYMBOL(<ls_ngc_api_msg>).
        ls_symsg = CORRESPONDING #( <ls_ngc_api_msg> ).

        DATA(ls_clfnobject) = VALUE #( it_clfnobject[
            clfnobjectid    = <ls_ngc_api_msg>-object_key
            clfnobjecttable = <ls_ngc_api_msg>-technical_object ] OPTIONAL ).

        APPEND INITIAL LINE TO ct_reported-object ASSIGNING <ls_reported>.
        <ls_reported>-%cid            = ls_clfnobject-cid.
        <ls_reported>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
        <ls_reported>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
        <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO ct_failed-object ASSIGNING <ls_failed>.
          <ls_failed>-%cid            = ls_clfnobject-cid.
          <ls_failed>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
          <ls_failed>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
          <ls_failed>-%fail-cause     = iv_cause.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.