  METHOD read_ref_values.

    DATA:
      lv_objchk_name TYPE rs38l_fnam,
      lv_exists      TYPE abap_bool,
      lt_otab        TYPE TABLE OF rmclobtx,
      lx_root        TYPE REF TO cx_root,
      lv_exc_text    TYPE string.

    CLEAR: lt_otab, rt_reftabs.

    lv_exists = abap_false.

    " First we have to determine OBJECT_CHECK_<NAME>
    lv_objchk_name = me->get_objchk_name( iv_obtab ).

    IF lv_objchk_name = gc_no_name.
      RETURN.
    ENDIF.

    " Fill otab.
    APPEND INITIAL LINE TO lt_otab ASSIGNING FIELD-SYMBOL(<ls_otab>).
    <ls_otab>-objek = iv_objek.

    " Call the OBJECT_CHECK_<NAME>.
    TRY.
        TEST-SEAM obj_chk_seam.
          CALL FUNCTION lv_objchk_name
            EXPORTING
              called_from      = '2'
              language         = mv_language
              lock             = abap_false
              single           = abap_true
              date_of_change   = iv_datuv
            TABLES
              otab             = lt_otab
            EXCEPTIONS
              error_message    = 1
              object_not_found = 2
              foreign_lock     = 3
              system_failure   = 4
              OTHERS           = 5.
        END-TEST-SEAM.

      CATCH cx_root INTO lx_root ##CATCH_ALL.
        lv_exc_text = lx_root->get_text( ).
        sy-subrc = 6.
    ENDTRY.

    CASE sy-subrc.
      WHEN 0.
        lv_exists = abap_true.

      WHEN 1.
        " An error MESSAGE is raised in the FM.
        mo_conv_logger->log_message(
          iv_id     = CONV #( sy-msgid )
          iv_type   = 'W'
          iv_number = CONV #( sy-msgno )
          iv_param1 = CONV #( sy-msgv1 )
          iv_param2 = CONV #( sy-msgv2 )
          iv_param3 = CONV #( sy-msgv3 )
          iv_param4 = CONV #( sy-msgv4 )
        ) ##NO_TEXT.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'W'
          iv_number = '035'
          iv_param1 = 'Error message (previous line) in '
          iv_param2 = lv_objchk_name && ':'
          iv_param3 = 'objek = '
          iv_param4 = CONV #( iv_objek )
        ) ##NO_TEXT.

        ASSIGN ct_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_errmsg   param = '' ] TO FIELD-SYMBOL(<ls_event>).

        IF sy-subrc IS INITIAL.
          <ls_event>-count += 1.
        ELSE.
          APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_errmsg param = '' count = 1 ) TO ct_events.
        ENDIF.

        RETURN.

      WHEN 2.
        " The BO does not exist at this date.

      WHEN 3.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'W'
          iv_number = '035'
          iv_param1 = 'Business Object is foreign locked: obtab = '
          iv_param2 = CONV #( iv_obtab )
          iv_param3 = ' objek = '
          iv_param4 = CONV #( iv_objek )
        ) ##NO_TEXT.

        ASSIGN ct_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_flock   param = '' ] TO <ls_event>.

        IF sy-subrc IS INITIAL.
          <ls_event>-count += 1.
        ELSE.
          APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_flock param = '' count = 1 ) TO ct_events.
        ENDIF.

        RETURN.

      WHEN 4 OR 5.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'W'
          iv_number = '035'
          iv_param1 = 'Failure when accessing Business Object: obtab = '
          iv_param2 = CONV #( iv_obtab )
          iv_param3 = ' objek = '
          iv_param4 = CONV #( iv_objek )
        ) ##NO_TEXT.

        ASSIGN ct_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail   param = '' ] TO <ls_event>.

        IF sy-subrc IS INITIAL.
          <ls_event>-count += 1.
        ELSE.
          APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail param = '' count = 1 ) TO ct_events.
        ENDIF.

        RETURN.

      WHEN 6.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'W'
          iv_number = '035'
          iv_param1 = `Exception got from ` && lv_objchk_name
          iv_param2 = ` objek = ` && iv_objek
          iv_param3 = `  `
          iv_param4 = lv_exc_text
        ) ##NO_TEXT.

        ASSIGN ct_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail   param = '' ] TO <ls_event>.

        IF sy-subrc IS INITIAL.
          <ls_event>-count += 1.
        ELSE.
          APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail param = '' count = 1 ) TO ct_events.
        ENDIF.

        RETURN.

    ENDCASE.

    IF lv_exists = abap_true.
      " Get the results.
      rt_reftabs = mo_conv_util->has_object_area( ).
    ELSE.
      mo_conv_logger->log_message(
        iv_id     = 'UPGBA'
        iv_type   = 'W'
        iv_number = '035'
        iv_param1 = 'Business Object not found: obtab = '
        iv_param2 = CONV #( iv_obtab )
        iv_param3 = ' objek = '
        iv_param4 = CONV #( iv_objek )
      ) ##NO_TEXT.

      ASSIGN ct_events[ event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_nexist   param = '' ] TO <ls_event>.

      IF sy-subrc IS INITIAL.
        <ls_event>-count += 1.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
    ENDIF.

  ENDMETHOD.