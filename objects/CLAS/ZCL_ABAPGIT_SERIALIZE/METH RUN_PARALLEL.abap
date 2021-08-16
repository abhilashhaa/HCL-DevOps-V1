  METHOD run_parallel.

    DATA: lv_msg  TYPE c LENGTH 100,
          lv_free LIKE mv_free.


    ASSERT mv_free > 0.

    DO.
      CALL FUNCTION 'Z_ABAPGIT_SERIALIZE_PARALLEL'
        STARTING NEW TASK iv_task
        DESTINATION IN GROUP mv_group
        CALLING on_end_of_task ON END OF TASK
        EXPORTING
          iv_obj_type           = is_tadir-object
          iv_obj_name           = is_tadir-obj_name
          iv_devclass           = is_tadir-devclass
          iv_language           = iv_language
          iv_path               = is_tadir-path
          iv_serialize_master_lang_only = mv_serialize_master_lang_only
        EXCEPTIONS
          system_failure        = 1 MESSAGE lv_msg
          communication_failure = 2 MESSAGE lv_msg
          resource_failure      = 3
          OTHERS                = 4.
      IF sy-subrc = 3.
        lv_free = mv_free.
        WAIT UNTIL mv_free <> lv_free UP TO 1 SECONDS.
        CONTINUE.
      ELSEIF sy-subrc <> 0.
        ASSERT lv_msg = '' AND 0 = 1.
      ENDIF.
      EXIT.
    ENDDO.

    mv_free = mv_free - 1.

  ENDMETHOD.