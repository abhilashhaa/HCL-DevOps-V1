  METHOD set_oo_parameters.

    DATA: ls_param LIKE LINE OF it_rsparam.

    IF cs_rsstcd-call_tcode = c_oo_tcode.
      cs_rsstcd-s_trframe = c_true.
      LOOP AT it_rsparam INTO ls_param.
        CASE ls_param-field.
          WHEN c_oo_frclass.
            cs_rsstcd-classname = ls_param-value.
          WHEN c_oo_frmethod.
            cs_rsstcd-method   = ls_param-value.
          WHEN c_oo_frupdtask.
            IF ls_param-value = c_oo_synchron.
              cs_rsstcd-s_upddir  = c_true.
              cs_rsstcd-s_updtask = c_false.
              cs_rsstcd-s_updlok  = c_false.
            ELSEIF ls_param-value = c_oo_asynchron.
              cs_rsstcd-s_upddir  = c_false.
              cs_rsstcd-s_updtask = c_true.
              cs_rsstcd-s_updlok  = c_false.
            ELSE.
              cs_rsstcd-s_upddir  = c_false.
              cs_rsstcd-s_updtask = c_false.
              cs_rsstcd-s_updlok  = c_true.
            ENDIF.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.