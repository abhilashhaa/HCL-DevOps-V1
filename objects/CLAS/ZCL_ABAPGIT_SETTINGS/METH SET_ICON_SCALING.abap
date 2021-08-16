  METHOD set_icon_scaling.
    ms_user_settings-icon_scaling = iv_scaling.
    IF ms_user_settings-icon_scaling NA c_icon_scaling.
      ms_user_settings-icon_scaling = ''. " Reset to default
    ENDIF.
  ENDMETHOD.