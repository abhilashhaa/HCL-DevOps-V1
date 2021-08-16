  METHOD on_end_of_task.

    DATA: lv_result    TYPE xstring,
          lv_path      TYPE string,
          lv_mess      TYPE c LENGTH 200,
          ls_fils_item TYPE zcl_abapgit_objects=>ty_serialization.


    RECEIVE RESULTS FROM FUNCTION 'Z_ABAPGIT_SERIALIZE_PARALLEL'
      IMPORTING
        ev_result = lv_result
        ev_path   = lv_path
      EXCEPTIONS
        error     = 1
        system_failure = 2 MESSAGE lv_mess
        communication_failure = 3 MESSAGE lv_mess
        OTHERS = 4.
    IF sy-subrc <> 0.
      IF NOT mi_log IS INITIAL.
        IF NOT lv_mess IS INITIAL.
          mi_log->add_error( lv_mess ).
        ELSE.
          mi_log->add_error( |{ sy-msgv1 }{ sy-msgv2 }{ sy-msgv3 }{ sy-msgv3 }, { sy-subrc }| ).
        ENDIF.
      ENDIF.
    ELSE.
      IMPORT data = ls_fils_item FROM DATA BUFFER lv_result. "#EC CI_SUBRC
      ASSERT sy-subrc = 0.
      add_to_return( is_fils_item = ls_fils_item
                     iv_path      = lv_path ).
    ENDIF.

    mv_free = mv_free + 1.

  ENDMETHOD.