  METHOD render_settings.

    DATA: lt_settings LIKE is_per-settings,
          ls_setting  LIKE LINE OF lt_settings.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF is_per-method IS INITIAL.
      RETURN.
    ENDIF.

    lt_settings = is_per-settings.

* skip invalid values, from old background logic
    IF is_per-method <> 'push' AND is_per-method <> 'pull' AND is_per-method <> 'nothing'.
      CALL METHOD (is_per-method)=>zif_abapgit_background~get_settings
        CHANGING
          ct_settings = lt_settings.
    ENDIF.

    IF lines( lt_settings ) = 0.
      RETURN.
    ENDIF.

    ri_html->add( '<table>' ).
    LOOP AT lt_settings INTO ls_setting.
      ri_html->add( '<tr>' ).
      ri_html->add( '<td>' && ls_setting-key && ':</td>' ).
      ri_html->add( '<td><input type="text" name="' &&
        ls_setting-key && '" value="' &&
        ls_setting-value && '"></td>' ).
      ri_html->add( '</tr>' ).
    ENDLOOP.
    ri_html->add( '</table>' ).

  ENDMETHOD.