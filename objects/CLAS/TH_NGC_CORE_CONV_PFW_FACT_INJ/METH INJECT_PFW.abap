  METHOD inject_pfw.

    ASSIGN cl_ngc_core_conv_pfw_fact=>gt_pfw[ application_name = iv_application_name ] TO FIELD-SYMBOL(<ls_pfw>).

    IF <ls_pfw> IS ASSIGNED.
      <ls_pfw>-pfw = io_instance.
    ELSE.
      APPEND INITIAL LINE TO cl_ngc_core_conv_pfw_fact=>gt_pfw ASSIGNING <ls_pfw>.
      <ls_pfw>-application_name = iv_application_name.
      <ls_pfw>-pfw = io_instance.
    ENDIF.

  ENDMETHOD.