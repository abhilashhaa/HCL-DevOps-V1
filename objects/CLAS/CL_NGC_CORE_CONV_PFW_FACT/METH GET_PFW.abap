  METHOD get_pfw.

    ro_instance = VALUE #( gt_pfw[ application_name = iv_application_name ]-pfw OPTIONAL ).

    IF ro_instance IS INITIAL.
      ro_instance = NEW cl_ngc_core_conv_pfw( iv_application_name ).

      APPEND INITIAL LINE TO gt_pfw ASSIGNING FIELD-SYMBOL(<ls_pfw>).
      <ls_pfw>-application_name = iv_application_name.
      <ls_pfw>-pfw = ro_instance.
    ENDIF.

  ENDMETHOD.