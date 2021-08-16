  METHOD activate_ddic.

    DATA: lt_gentab     TYPE STANDARD TABLE OF dcgentb,
          lv_rc         TYPE sy-subrc,
          ls_gentab     LIKE LINE OF lt_gentab,
          lt_deltab     TYPE STANDARD TABLE OF dcdeltb,
          lt_action_tab TYPE STANDARD TABLE OF dctablres,
          lv_logname    TYPE ddmass-logname.

    FIELD-SYMBOLS: <ls_object> LIKE LINE OF gt_objects.


    LOOP AT gt_objects ASSIGNING <ls_object>.
      ls_gentab-tabix = sy-tabix.
      ls_gentab-type = <ls_object>-object.
      ls_gentab-name = <ls_object>-obj_name.
      IF ls_gentab-type = 'INDX'.
        CALL FUNCTION 'DD_E071_TO_DD'
          EXPORTING
            object   = <ls_object>-object
            obj_name = <ls_object>-obj_name
          IMPORTING
            name     = ls_gentab-name
            id       = ls_gentab-indx.
      ENDIF.
      INSERT ls_gentab INTO TABLE lt_gentab.
    ENDLOOP.

    IF lt_gentab IS NOT INITIAL.

      lv_logname = |ABAPGIT_{ sy-datum }_{ sy-uzeit }|.

      CALL FUNCTION 'DD_MASS_ACT_C3'
        EXPORTING
          ddmode         = 'O'
          medium         = 'T' " transport order
          device         = 'T' " saves to table DDRPH?
          version        = 'M' " activate newest
          logname        = lv_logname
          write_log      = abap_true
          log_head_tail  = abap_true
          t_on           = space
          prid           = 1
        IMPORTING
          act_rc         = lv_rc
        TABLES
          gentab         = lt_gentab
          deltab         = lt_deltab
          cnvtab         = lt_action_tab
        EXCEPTIONS
          access_failure = 1
          no_objects     = 2
          locked         = 3
          internal_error = 4
          OTHERS         = 5.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from DD_MASS_ACT_C3' ).
      ENDIF.

      IF lv_rc > 0.
        show_activation_errors( lv_logname ).
      ENDIF.

    ENDIF.

  ENDMETHOD.