  METHOD decode.

    DATA: lt_fields TYPE tihttpnvp.

    FIELD-SYMBOLS: <ls_setting> LIKE LINE OF rs_fields-settings.


    rs_fields-key = mv_key.

    lt_fields = zcl_abapgit_html_action_utils=>parse_fields_upper_case_name( iv_getdata ).

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'METHOD'
        it_field   = lt_fields
      CHANGING
        cg_field   = rs_fields ).
    IF rs_fields-method IS INITIAL.
      RETURN.
    ENDIF.

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'USERNAME'
        it_field   = lt_fields
      CHANGING
        cg_field   = rs_fields ).

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'PASSWORD'
        it_field   = lt_fields
      CHANGING
        cg_field   = rs_fields ).


    CALL METHOD (rs_fields-method)=>zif_abapgit_background~get_settings
      CHANGING
        ct_settings = rs_fields-settings.
    LOOP AT rs_fields-settings ASSIGNING <ls_setting>.
      zcl_abapgit_html_action_utils=>get_field(
        EXPORTING
          iv_name = <ls_setting>-key
          it_field   = lt_fields
        CHANGING
          cg_field   = <ls_setting>-value ).
    ENDLOOP.

    ASSERT NOT rs_fields IS INITIAL.

  ENDMETHOD.