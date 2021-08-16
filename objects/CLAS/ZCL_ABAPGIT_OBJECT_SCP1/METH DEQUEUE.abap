  METHOD dequeue.

    DATA: lv_id TYPE scpr_id.


    lv_id = ms_item-obj_name.

    CALL FUNCTION 'SCPR_SV_DEQUEUE_BCSET'
      EXPORTING
        bcset_id = lv_id.

  ENDMETHOD.