  METHOD update_repo_config.

    DATA: ls_user TYPE ty_user,
          lv_key  TYPE string.

    FIELD-SYMBOLS <ls_repo_config> TYPE ty_repo_config.


    ls_user = read( ).
    lv_key  = to_lower( iv_url ).

    READ TABLE ls_user-repo_config ASSIGNING <ls_repo_config> WITH KEY url = lv_key.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO ls_user-repo_config ASSIGNING <ls_repo_config>.
    ENDIF.
    <ls_repo_config>     = is_repo_config.
    <ls_repo_config>-url = lv_key.

    update( ls_user ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.