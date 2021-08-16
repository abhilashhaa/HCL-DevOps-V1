  METHOD if_ngc_bil_clf~exec_obj_checkconsistency.

    mo_ngc_api->if_ngc_clf_api_write~validate(
      EXPORTING
        it_classification_object = mt_classification
      IMPORTING
        eo_clf_api_result        = DATA(lo_clf_api_result) ).

    " Action is static so object key is not available. We only have to return the %CID properly.
    DATA(lt_ngc_api_msg) = lo_clf_api_result->get_messages( ).

    LOOP AT lt_ngc_api_msg REFERENCE INTO DATA(lr_message).
      DATA(ls_symsg) = CORRESPONDING symsg( lr_message->* ).

      LOOP AT it_input REFERENCE INTO DATA(lr_input).
        APPEND INITIAL LINE TO es_reported-object ASSIGNING FIELD-SYMBOL(<ls_reported>).
        <ls_reported>-%cid = lr_input->%cid.
        <ls_reported>-%msg = mo_sy_msg_convert->map_symsg_to_behv_message( ls_symsg ).

        IF ls_symsg-msgty CA gc_error_codes.
          APPEND INITIAL LINE TO es_failed-object ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%cid                     = lr_input->%cid.
          <ls_failed>-%action-checkconsistency = cl_abap_behv=>flag_changed.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.