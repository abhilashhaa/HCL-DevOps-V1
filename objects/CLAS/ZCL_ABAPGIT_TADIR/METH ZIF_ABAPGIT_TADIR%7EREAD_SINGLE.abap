  METHOD zif_abapgit_tadir~read_single.

    IF iv_object = 'SICF'.
      TRY.
          CALL METHOD ('ZCL_ABAPGIT_OBJECT_SICF')=>read_tadir
            EXPORTING
              iv_pgmid    = iv_pgmid
              iv_obj_name = iv_obj_name
            RECEIVING
              rs_tadir    = rs_tadir.
        CATCH cx_sy_dyn_call_illegal_method ##NO_HANDLER.
* SICF might not be supported in some systems, assume this code is not called
      ENDTRY.
    ELSE.
      SELECT SINGLE * FROM tadir INTO CORRESPONDING FIELDS OF rs_tadir
        WHERE pgmid = iv_pgmid
        AND object = iv_object
        AND obj_name = iv_obj_name.                       "#EC CI_SUBRC
    ENDIF.

  ENDMETHOD.