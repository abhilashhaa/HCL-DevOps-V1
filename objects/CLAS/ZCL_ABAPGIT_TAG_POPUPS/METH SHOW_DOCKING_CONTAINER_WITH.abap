  METHOD show_docking_container_with.

    IF mo_docking_container IS NOT BOUND.

      CREATE OBJECT mo_docking_container
        EXPORTING
          side                        = cl_gui_docking_container=>dock_at_bottom
          extension                   = 120
        EXCEPTIONS
          cntl_error                  = 1
          cntl_system_error           = 2
          create_error                = 3
          lifetime_error              = 4
          lifetime_dynpro_dynpro_link = 5
          OTHERS                      = 6.
      ASSERT sy-subrc = 0.

    ENDIF.

    IF mo_text_control IS NOT BOUND.
      CREATE OBJECT mo_text_control
        EXPORTING
          parent                 = mo_docking_container
        EXCEPTIONS
          error_cntl_create      = 1
          error_cntl_init        = 2
          error_cntl_link        = 3
          error_dp_create        = 4
          gui_type_not_supported = 5
          OTHERS                 = 6.
      ASSERT sy-subrc = 0.

      mo_text_control->set_readonly_mode(
        EXCEPTIONS
          error_cntl_call_method = 1
          invalid_parameter      = 2
          OTHERS                 = 3 ).
      ASSERT sy-subrc = 0.

    ENDIF.

    mo_text_control->set_textstream(
      EXPORTING
        text                   = iv_text
      EXCEPTIONS
        error_cntl_call_method = 1
        not_supported_by_gui   = 2
        OTHERS                 = 3 ).
    ASSERT sy-subrc = 0.

  ENDMETHOD.