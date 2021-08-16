  METHOD add_object_class_msg.

    CONSTANTS: lc_class_key_type TYPE string VALUE 'NGCS_CLASS_KEY'.

    FIELD-SYMBOLS: <ls_class_error_reference> TYPE ngcs_class_key.

    IF io_ngc_api_result IS NOT SUPPLIED.
      DATA(ls_symsg) = CORRESPONDING symsg( sy ).

      LOOP AT it_clfnobjectclass ASSIGNING FIELD-SYMBOL(<ls_clfnobjectclass>).
        APPEND INITIAL LINE TO ct_reported-objectclass ASSIGNING FIELD-SYMBOL(<ls_reported>).
        <ls_reported>-%cid            = <ls_clfnobjectclass>-cid.
        <ls_reported>-clfnobjectid    = <ls_clfnobjectclass>-clfnobjectid.
        <ls_reported>-clfnobjecttable = <ls_clfnobjectclass>-clfnobjecttable.
        <ls_reported>-classinternalid = <ls_clfnobjectclass>-classinternalid.
        <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO ct_failed-objectclass ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%cid            = <ls_clfnobjectclass>-cid.
          <ls_failed>-clfnobjectid    = <ls_clfnobjectclass>-clfnobjectid.
          <ls_failed>-clfnobjecttable = <ls_clfnobjectclass>-clfnobjecttable.
          <ls_failed>-classinternalid = <ls_clfnobjectclass>-classinternalid.
          <ls_failed>-%fail-cause     = iv_cause.
        ENDIF.
      ENDLOOP.
    ELSEIF io_ngc_api_result IS NOT INITIAL.
      DATA(lt_ngc_api_msg) = io_ngc_api_result->get_messages( ).

      LOOP AT lt_ngc_api_msg ASSIGNING FIELD-SYMBOL(<ls_ngc_api_msg>).
        ls_symsg = CORRESPONDING #( <ls_ngc_api_msg> ).

        IF <ls_ngc_api_msg>-ref_type = lc_class_key_type.
          ASSIGN <ls_ngc_api_msg>-ref_key->* TO <ls_class_error_reference>.

          DATA(ls_clfnobjectclass) = VALUE #( it_clfnobjectclass[
            clfnobjectid    = <ls_ngc_api_msg>-object_key
            clfnobjecttable = <ls_ngc_api_msg>-technical_object
            classinternalid = <ls_class_error_reference>-classinternalid ] OPTIONAL ).

          APPEND INITIAL LINE TO ct_reported-objectclass ASSIGNING <ls_reported>.
          <ls_reported>-%cid            = ls_clfnobjectclass-cid.
          <ls_reported>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
          <ls_reported>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
          <ls_reported>-classinternalid = <ls_class_error_reference>-classinternalid.
          <ls_reported>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

          IF ls_symsg-msgty CA gc_error_codes.
            APPEND INITIAL LINE TO ct_failed-objectclass ASSIGNING <ls_failed>.
            <ls_failed>-%cid            = ls_clfnobjectclass-cid.
            <ls_failed>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
            <ls_failed>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
            <ls_failed>-classinternalid = <ls_class_error_reference>-classinternalid.
            <ls_failed>-%fail-cause     = iv_cause.
          ENDIF.
        ELSE.
          APPEND INITIAL LINE TO ct_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported_object>).
          <ls_reported_object>-clfnobjectid    = <ls_ngc_api_msg>-object_key.
          <ls_reported_object>-clfnobjecttable = <ls_ngc_api_msg>-technical_object.
          <ls_reported_object>-%msg            = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

          IF ls_symsg-msgty CA gc_error_codes.
            LOOP AT it_clfnobjectclass ASSIGNING <ls_clfnobjectclass>
              WHERE
                clfnobjectid    = <ls_ngc_api_msg>-object_key AND
                clfnobjecttable = <ls_ngc_api_msg>-technical_object.

              APPEND INITIAL LINE TO ct_failed-objectclass ASSIGNING <ls_failed>.
              <ls_failed>-%cid            = <ls_clfnobjectclass>-cid.
              <ls_failed>-clfnobjectid    = <ls_clfnobjectclass>-clfnobjectid.
              <ls_failed>-clfnobjecttable = <ls_clfnobjectclass>-clfnobjecttable.
              <ls_failed>-classinternalid = <ls_clfnobjectclass>-classinternalid.
              <ls_failed>-%fail-cause     = iv_cause.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.