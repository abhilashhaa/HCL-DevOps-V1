  METHOD zif_abapgit_background~get_settings.

    DATA: ls_setting LIKE LINE OF ct_settings.


    READ TABLE ct_settings WITH KEY key = c_settings-name INTO ls_setting.
    IF sy-subrc <> 0.
      ls_setting-key = c_settings-name.
      ls_setting-value = 'foobar'.
      APPEND ls_setting TO ct_settings.
    ENDIF.

    READ TABLE ct_settings WITH KEY key = c_settings-email INTO ls_setting.
    IF sy-subrc <> 0.
      ls_setting-key = c_settings-email.
      ls_setting-value = 'foobar@localhost'.
      APPEND ls_setting TO ct_settings.
    ENDIF.

  ENDMETHOD.