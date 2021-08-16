  METHOD clean_up.

    IF mo_text_control IS BOUND.

      mo_text_control->finalize( ).
      mo_text_control->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3 ).
      ASSERT sy-subrc = 0.

      CLEAR: mo_text_control.

    ENDIF.

    IF mo_docking_container IS BOUND.

      mo_docking_container->finalize( ).
      mo_docking_container->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3 ).
      ASSERT sy-subrc = 0.

      CLEAR: mo_docking_container.

    ENDIF.

  ENDMETHOD.