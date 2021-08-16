  METHOD zif_abapgit_object~is_locked.

    DATA: lt_enq   TYPE STANDARD TABLE OF seqg3,
          lv_subrc TYPE sysubrc,
          lv_garg  TYPE eqegraarg.

    lv_garg = ms_item-obj_name.

    CALL FUNCTION 'ENQUEUE_READ'
      EXPORTING
        gclient               = sy-mandt
        gname                 = 'WDY_CONFIG_DATA'
        garg                  = lv_garg
      IMPORTING
        subrc                 = lv_subrc
      TABLES
        enq                   = lt_enq
      EXCEPTIONS
        communication_failure = 2
        OTHERS                = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error check object lock WDCC: ' && ms_item-obj_name ).
    ENDIF.

    rv_is_locked = boolc( lines( lt_enq ) > 0 ).

  ENDMETHOD.