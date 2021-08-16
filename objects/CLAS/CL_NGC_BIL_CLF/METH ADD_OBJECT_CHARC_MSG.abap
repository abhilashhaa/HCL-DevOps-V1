  METHOD add_object_charc_msg.

    CONSTANTS: lc_charc_key_type TYPE string VALUE 'NGCS_CLF_CHARACTERISTIC_KEY'.

    FIELD-SYMBOLS: <ls_charc_error_reference> TYPE ngcs_clf_characteristic_key.

    IF io_ngc_api_result IS NOT SUPPLIED.
      DATA(ls_symsg) = CORRESPONDING symsg( sy ).

      LOOP AT it_clfnobjectcharc ASSIGNING FIELD-SYMBOL(<ls_clfnobjectcharc>).
        APPEND INITIAL LINE TO ct_reported-objectcharc ASSIGNING FIELD-SYMBOL(<ls_reported>).
        <ls_reported>-%cid            = <ls_clfnobjectcharc>-cid.
        <ls_reported>-clfnobjectid    = <ls_clfnobjectcharc>-clfnobjectid.
        <ls_reported>-clfnobjecttable = <ls_clfnobjectcharc>-clfnobjecttable.
        <ls_reported>-charcinternalid = <ls_clfnobjectcharc>-charcinternalid.
        <ls_reported>-classtype       = <ls_clfnobjectcharc>-classtype.
        <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO ct_failed-objectcharc ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%cid            = <ls_clfnobjectcharc>-cid.
          <ls_failed>-clfnobjectid    = <ls_clfnobjectcharc>-clfnobjectid.
          <ls_failed>-clfnobjecttable = <ls_clfnobjectcharc>-clfnobjecttable.
          <ls_failed>-charcinternalid = <ls_clfnobjectcharc>-charcinternalid.
          <ls_failed>-classtype       = <ls_clfnobjectcharc>-classtype.
          <ls_failed>-%fail-cause     = iv_cause.
        ENDIF.
      ENDLOOP.
    ELSEIF io_ngc_api_result IS NOT INITIAL.
      DATA(lt_ngc_api_msg) = io_ngc_api_result->get_messages( ).

      LOOP AT lt_ngc_api_msg ASSIGNING FIELD-SYMBOL(<ls_ngc_api_msg>).
        ls_symsg = CORRESPONDING #( <ls_ngc_api_msg> ).

        IF <ls_ngc_api_msg>-ref_type = lc_charc_key_type.
          ASSIGN <ls_ngc_api_msg>-ref_key->* TO <ls_charc_error_reference>.

          DATA(ls_clfnobjectcharc) = VALUE #( it_clfnobjectcharc[
            clfnobjectid    = <ls_ngc_api_msg>-object_key
            clfnobjecttable = <ls_ngc_api_msg>-technical_object
            charcinternalid = <ls_charc_error_reference>-charcinternalid
            classtype       = <ls_charc_error_reference>-classtype ] OPTIONAL ).

          APPEND INITIAL LINE TO ct_reported-objectcharc ASSIGNING <ls_reported>.
          <ls_reported>-%cid            = ls_clfnobjectcharc-cid.
          <ls_reported>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
          <ls_reported>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
          <ls_reported>-charcinternalid = <ls_charc_error_reference>-charcinternalid.
          <ls_reported>-classtype       = <ls_charc_error_reference>-classtype.
          <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

          IF ls_symsg-msgty CA gc_error_codes.
            APPEND INITIAL LINE TO ct_failed-objectcharc ASSIGNING <ls_failed>.
            <ls_failed>-%cid            = ls_clfnobjectcharc-cid.
            <ls_failed>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
            <ls_failed>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
            <ls_failed>-charcinternalid = <ls_charc_error_reference>-charcinternalid.
            <ls_failed>-classtype       = <ls_charc_error_reference>-classtype.
            <ls_failed>-%fail-cause     = iv_cause.
          ENDIF.
        ELSE.
          APPEND INITIAL LINE TO ct_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported_object>).
          <ls_reported_object>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
          <ls_reported_object>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
          <ls_reported_object>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

          IF ls_symsg-msgty CA gc_error_codes.
            LOOP AT it_clfnobjectcharc ASSIGNING <ls_clfnobjectcharc>
              WHERE
                clfnobjectid    = <ls_ngc_api_msg>-object_key AND
                clfnobjecttable = <ls_ngc_api_msg>-technical_object.

              APPEND INITIAL LINE TO ct_failed-objectcharc ASSIGNING <ls_failed>.
              <ls_failed>-%cid            = ls_clfnobjectcharc-cid.
              <ls_failed>-clfnobjectid    = <ls_clfnobjectcharc>-clfnobjectid.
              <ls_failed>-clfnobjecttable = <ls_clfnobjectcharc>-clfnobjecttable.
              <ls_failed>-charcinternalid = <ls_clfnobjectcharc>-charcinternalid.
              <ls_failed>-classtype       = <ls_clfnobjectcharc>-classtype.
              <ls_failed>-%fail-cause     = iv_cause.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.