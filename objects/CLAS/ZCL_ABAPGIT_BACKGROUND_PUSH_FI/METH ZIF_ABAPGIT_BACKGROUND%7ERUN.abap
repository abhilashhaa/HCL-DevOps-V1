  METHOD zif_abapgit_background~run.

    DATA: ls_files   TYPE zif_abapgit_definitions=>ty_stage_files,
          ls_setting LIKE LINE OF it_settings,
          lv_name    TYPE string,
          lv_email   TYPE string.

    mi_log = ii_log.
    ls_files = zcl_abapgit_factory=>get_stage_logic( )->get( io_repo ).

    IF lines( ls_files-local ) = 0 AND lines( ls_files-remote ) = 0.
      ii_log->add_info( 'Nothing to stage' ).
      RETURN.
    ENDIF.

    READ TABLE it_settings WITH KEY key = c_settings-name INTO ls_setting. "#EC CI_SUBRC
    lv_name = ls_setting-value.

    READ TABLE it_settings WITH KEY key = c_settings-email INTO ls_setting. "#EC CI_SUBRC
    lv_email = ls_setting-value.

    push_fixed(
      io_repo  = io_repo
      iv_name  = lv_name
      iv_email = lv_email ).

  ENDMETHOD.