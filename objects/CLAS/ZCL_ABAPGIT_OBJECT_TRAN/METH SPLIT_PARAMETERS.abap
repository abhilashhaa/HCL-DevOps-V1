  METHOD split_parameters.
* see subroutine split_parameters in include LSEUKF01

    DATA: lv_off       TYPE i,
          lv_param_beg TYPE i.


    CLEAR cs_rsstcd-s_vari.

    IF cs_tstcp-param(1) = '\'.             " OO-Transaktion ohne FR
      split_parameters_comp( EXPORTING ig_type = c_oo_program
                                       ig_param = cs_tstcp-param
                             CHANGING  cg_value = cs_tstc-pgmna ).
      split_parameters_comp( EXPORTING ig_type = c_oo_class
                                       ig_param = cs_tstcp-param
                             CHANGING  cg_value = cs_rsstcd-classname ).
      split_parameters_comp( EXPORTING ig_type = c_oo_method
                                       ig_param = cs_tstcp-param
                             CHANGING  cg_value = cs_rsstcd-method ).

      IF NOT cs_tstc-pgmna IS INITIAL.
        cs_rsstcd-s_local = c_true.
      ENDIF.
      RETURN.
    ELSEIF cs_tstcp-param(1) = '@'.         " Transaktionsvariante
      cs_rsstcd-s_vari = c_true.
      IF cs_tstcp-param(2) = '@@'.
        cs_rsstcd-s_ind_vari = c_true.
        lv_off = 2.
      ELSE.
        CLEAR cs_rsstcd-s_ind_vari.
        lv_off = 1.
      ENDIF.
      IF cs_tstcp-param CA ' '.
      ENDIF.
      sy-fdpos = sy-fdpos - lv_off.
      IF sy-fdpos > 0.
        cs_rsstcd-call_tcode = cs_tstcp-param+lv_off(sy-fdpos).
        sy-fdpos = sy-fdpos + 1 + lv_off.
        cs_rsstcd-variant = cs_tstcp-param+sy-fdpos.
      ENDIF.
    ELSEIF cs_tstcp-param(1) = '/'.
      cs_rsstcd-st_tcode = c_true.
      cs_rsstcd-st_prog  = space.
      IF cs_tstcp-param+1(1) = '*'.
        cs_rsstcd-st_skip_1 = c_true.
      ELSE.
        CLEAR cs_rsstcd-st_skip_1.
      ENDIF.
      IF cs_tstcp-param CA ' '.
      ENDIF.
      lv_param_beg = sy-fdpos + 1.
      sy-fdpos = sy-fdpos - 2.
      IF sy-fdpos > 0.
        cs_rsstcd-call_tcode = cs_tstcp-param+2(sy-fdpos).
      ENDIF.
      SHIFT cs_tstcp-param BY lv_param_beg PLACES.
    ELSE.
      cs_rsstcd-st_tcode = space.
      cs_rsstcd-st_prog  = c_true.
    ENDIF.

    shift_param(
      CHANGING ct_rsparam = ct_rsparam
               cs_tstcp   = cs_tstcp ).

    set_oo_parameters(
      EXPORTING it_rsparam = ct_rsparam
      CHANGING cs_rsstcd = cs_rsstcd ).

  ENDMETHOD.