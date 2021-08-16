  METHOD add_object_charc_val_msg.

    CONSTANTS: lc_charc_key_type TYPE string VALUE 'NGCS_CLF_CHARACTERISTIC_KEY'.

    FIELD-SYMBOLS: <ls_charc_error_reference> TYPE ngcs_clf_characteristic_key.

    IF io_ngc_api_result IS NOT SUPPLIED.
      DATA(ls_symsg) = CORRESPONDING symsg( sy ).

      LOOP AT it_clfnobjectcharcval ASSIGNING FIELD-SYMBOL(<ls_clfnobjectcharcval>).
        APPEND INITIAL LINE TO ct_reported-objectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_reported>).
        <ls_reported>-%cid                     = <ls_clfnobjectcharcval>-cid.
        <ls_reported>-clfnobjectid             = <ls_clfnobjectcharcval>-clfnobjectid.
        <ls_reported>-clfnobjecttable          = <ls_clfnobjectcharcval>-clfnobjecttable.
        <ls_reported>-charcinternalid          = <ls_clfnobjectcharcval>-charcinternalid.
        <ls_reported>-classtype                = <ls_clfnobjectcharcval>-classtype.
        <ls_reported>-charcvaluepositionnumber = <ls_clfnobjectcharcval>-charcvaluepositionnumber.
        <ls_reported>-%msg                     = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO ct_failed-objectcharcvalue ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%cid                     = <ls_clfnobjectcharcval>-cid.
          <ls_failed>-clfnobjectid             = <ls_clfnobjectcharcval>-clfnobjectid.
          <ls_failed>-clfnobjecttable          = <ls_clfnobjectcharcval>-clfnobjecttable.
          <ls_failed>-charcinternalid          = <ls_clfnobjectcharcval>-charcinternalid.
          <ls_failed>-classtype                = <ls_clfnobjectcharcval>-classtype.
          <ls_failed>-charcvaluepositionnumber = <ls_clfnobjectcharcval>-charcvaluepositionnumber.
          <ls_failed>-%fail-cause              = iv_cause.
        ENDIF.
      ENDLOOP.
    ELSEIF io_ngc_api_result IS NOT INITIAL.
      DATA(lt_ngc_api_msg) = io_ngc_api_result->get_messages( ).

      IF lines( it_clfnobjectcharcval ) = 1.
        DATA(ls_clfnobjectcharcval) = it_clfnobjectcharcval[ 1 ].

        LOOP AT lt_ngc_api_msg ASSIGNING FIELD-SYMBOL(<ls_ngc_api_msg>).
          ls_symsg = CORRESPONDING #( <ls_ngc_api_msg> ).

          APPEND INITIAL LINE TO ct_reported-objectcharcvalue ASSIGNING <ls_reported>.
          <ls_reported>-%cid                     = ls_clfnobjectcharcval-cid.
          <ls_reported>-clfnobjectid             = ls_clfnobjectcharcval-clfnobjectid.
          <ls_reported>-clfnobjecttable          = ls_clfnobjectcharcval-clfnobjecttable.
          <ls_reported>-charcinternalid          = ls_clfnobjectcharcval-charcinternalid.
          <ls_reported>-classtype                = ls_clfnobjectcharcval-classtype.
          <ls_reported>-charcvaluepositionnumber = ls_clfnobjectcharcval-charcvaluepositionnumber.
          <ls_reported>-%msg                     = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).
        ENDLOOP.

        IF io_ngc_api_result->has_error_or_worse( ) = abap_true.
          APPEND INITIAL LINE TO ct_failed-objectcharcvalue ASSIGNING <ls_failed>.
          <ls_failed>-%cid                     = ls_clfnobjectcharcval-cid.
          <ls_failed>-clfnobjectid             = ls_clfnobjectcharcval-clfnobjectid.
          <ls_failed>-clfnobjecttable          = ls_clfnobjectcharcval-clfnobjecttable.
          <ls_failed>-charcinternalid          = ls_clfnobjectcharcval-charcinternalid.
          <ls_failed>-classtype                = ls_clfnobjectcharcval-classtype.
          <ls_failed>-charcvaluepositionnumber = ls_clfnobjectcharcval-charcvaluepositionnumber.
          <ls_failed>-%fail-cause              = iv_cause.
        ENDIF.
      ELSE.
        LOOP AT lt_ngc_api_msg ASSIGNING <ls_ngc_api_msg>.
          ls_symsg = CORRESPONDING #( <ls_ngc_api_msg> ).

          " I couldn't find any types for value returned by NGC API. Error handling should be extended if such exists.
          IF <ls_ngc_api_msg>-ref_type = lc_charc_key_type.
            ASSIGN <ls_ngc_api_msg>-ref_key->* TO <ls_charc_error_reference>.

            APPEND INITIAL LINE TO ct_reported-objectcharc ASSIGNING FIELD-SYMBOL(<ls_reported_charc>).
            <ls_reported_charc>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
            <ls_reported_charc>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
            <ls_reported_charc>-charcinternalid = <ls_charc_error_reference>-charcinternalid.
            <ls_reported_charc>-classtype       = <ls_charc_error_reference>-classtype.
            <ls_reported_charc>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).
          ELSE.
            APPEND INITIAL LINE TO ct_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported_object>).
            <ls_reported_object>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
            <ls_reported_object>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
            <ls_reported_object>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).
          ENDIF.

          IF ls_symsg-msgty CA gc_error_codes.
            LOOP AT it_clfnobjectcharcval ASSIGNING <ls_clfnobjectcharcval>
              WHERE
                clfnobjectid    = <ls_ngc_api_msg>-object_key AND
                clfnobjecttable = <ls_ngc_api_msg>-technical_object.

              APPEND INITIAL LINE TO ct_failed-objectcharcvalue ASSIGNING <ls_failed>.
              <ls_failed>-clfnobjectid             = <ls_clfnobjectcharcval>-clfnobjectid.
              <ls_failed>-clfnobjecttable          = <ls_clfnobjectcharcval>-clfnobjecttable.
              <ls_failed>-charcinternalid          = <ls_clfnobjectcharcval>-charcinternalid.
              <ls_failed>-classtype                = <ls_clfnobjectcharcval>-classtype.
              <ls_failed>-charcvaluepositionnumber = <ls_clfnobjectcharcval>-charcvaluepositionnumber.
              <ls_failed>-%fail-cause              = iv_cause.
            ENDLOOP.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ENDMETHOD.