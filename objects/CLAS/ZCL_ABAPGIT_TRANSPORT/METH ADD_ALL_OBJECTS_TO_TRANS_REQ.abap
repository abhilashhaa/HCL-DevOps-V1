  METHOD add_all_objects_to_trans_req.

    DATA:
      ls_request      TYPE trwbo_request_header,
      lt_e071         TYPE tr_objects,
      lv_text         TYPE string,
      lv_answer       TYPE c LENGTH 1,
      lv_lock_objects TYPE trparflag.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
                    iv_titlebar              = `Lock objects?`
                    iv_text_question         = `Shall all objects be locked in the transport request?`
                    iv_display_cancel_button = abap_true ).

    CASE lv_answer.
      WHEN '1'.
        lv_lock_objects = abap_true.
      WHEN '2'.
        lv_lock_objects = abap_false.
      WHEN OTHERS.
        RETURN.
    ENDCASE.

    lt_e071 = collect_all_objects( iv_key ).

    CALL FUNCTION 'TR_REQUEST_CHOICE'
      EXPORTING
        it_e071              = lt_e071
        iv_lock_objects      = lv_lock_objects
      IMPORTING
        es_request           = ls_request
      EXCEPTIONS
        invalid_request      = 1
        invalid_request_type = 2
        user_not_owner       = 3
        no_objects_appended  = 4
        enqueue_error        = 5
        cancelled_by_user    = 6
        recursive_call       = 7
        OTHERS               = 8.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    lv_text = |Objects successfully added to { ls_request-trkorr }|.
    MESSAGE lv_text TYPE 'S'.

  ENDMETHOD.