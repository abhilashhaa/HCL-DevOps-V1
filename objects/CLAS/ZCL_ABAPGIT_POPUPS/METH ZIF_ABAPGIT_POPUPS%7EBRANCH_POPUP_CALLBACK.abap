  METHOD zif_abapgit_popups~branch_popup_callback.

    DATA: lv_url          TYPE string,
          ls_package_data TYPE scompkdtln,
          ls_branch       TYPE zif_abapgit_definitions=>ty_git_branch,
          lv_create       TYPE abap_bool,
          lv_text         TYPE string.

    FIELD-SYMBOLS: <ls_furl>     LIKE LINE OF ct_fields,
                   <ls_fbranch>  LIKE LINE OF ct_fields,
                   <ls_fpackage> LIKE LINE OF ct_fields.

    CLEAR cs_error.

    IF iv_code = 'COD1'.
      cv_show_popup = abap_true.

      READ TABLE ct_fields ASSIGNING <ls_furl> WITH KEY tabname = 'ABAPTXT255'.
      IF sy-subrc <> 0 OR <ls_furl>-value IS INITIAL.
        MESSAGE 'Fill URL' TYPE 'S' DISPLAY LIKE 'E'.
        RETURN.
      ENDIF.
      lv_url = <ls_furl>-value.

      ls_branch = branch_list_popup( lv_url ).
      IF ls_branch IS INITIAL.
        RETURN.
      ENDIF.

      READ TABLE ct_fields ASSIGNING <ls_fbranch> WITH KEY tabname = 'TEXTL'.
      ASSERT sy-subrc = 0.
      <ls_fbranch>-value = ls_branch-name.

    ELSEIF iv_code = 'COD2'.
      cv_show_popup = abap_true.

      READ TABLE ct_fields ASSIGNING <ls_fpackage> WITH KEY fieldname = 'DEVCLASS'.
      ASSERT sy-subrc = 0.
      ls_package_data-devclass = <ls_fpackage>-value.

      IF zcl_abapgit_factory=>get_sap_package( ls_package_data-devclass )->exists( ) = abap_true.
        lv_text = |Package { ls_package_data-devclass } already exists|.
        MESSAGE lv_text TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
      ENDIF.

      popup_to_create_package(
        IMPORTING
          es_package_data = ls_package_data
          ev_create       = lv_create ).
      IF lv_create = abap_false.
        RETURN.
      ENDIF.

      zcl_abapgit_factory=>get_sap_package( ls_package_data-devclass )->create( ls_package_data ).
      COMMIT WORK.

      <ls_fpackage>-value = ls_package_data-devclass.
    ENDIF.

  ENDMETHOD.