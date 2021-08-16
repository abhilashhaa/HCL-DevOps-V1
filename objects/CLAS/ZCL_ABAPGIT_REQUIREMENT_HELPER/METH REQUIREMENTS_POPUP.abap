  METHOD requirements_popup.

    DATA: lt_met_status TYPE ty_requirement_status_tt,
          lv_answer     TYPE c LENGTH 1.


    lt_met_status = get_requirement_met_status( it_requirements ).

    show_requirement_popup( lt_met_status ).

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        text_question = 'The project has unmet requirements. Do you want to continue?'
      IMPORTING
        answer        = lv_answer.
    IF lv_answer <> '1'.
      zcx_abapgit_exception=>raise( 'Cancelling because of unmet requirements.' ).
    ENDIF.

  ENDMETHOD.