  METHOD zif_abapgit_popups~package_popup_callback.

    DATA: ls_package_data TYPE scompkdtln,
          lv_create       TYPE abap_bool.

    FIELD-SYMBOLS: <ls_fpackage> LIKE LINE OF ct_fields.

    CLEAR cs_error.

    IF iv_code = 'COD1'.
      cv_show_popup = abap_true.

      READ TABLE ct_fields ASSIGNING <ls_fpackage> WITH KEY fieldname = 'DEVCLASS'.
      ASSERT sy-subrc = 0.
      ls_package_data-devclass = <ls_fpackage>-value.

      popup_to_create_package( IMPORTING es_package_data = ls_package_data
                                         ev_create       = lv_create ).
      IF lv_create = abap_false.
        RETURN.
      ENDIF.

      zcl_abapgit_factory=>get_sap_package( ls_package_data-devclass )->create( ls_package_data ).
      COMMIT WORK.

      <ls_fpackage>-value = ls_package_data-devclass.
    ENDIF.

  ENDMETHOD.