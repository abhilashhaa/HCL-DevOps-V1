  METHOD open_ie_devtools.
    DATA: lv_system_directory TYPE string,
          lv_exe_full_path    TYPE string.

    IF zcl_abapgit_ui_factory=>get_gui_functions( )->is_sapgui_for_windows( ) = abap_false.
      zcx_abapgit_exception=>raise( |IE DevTools not supported on frontend OS| ).
    ENDIF.

    cl_gui_frontend_services=>get_system_directory(
      CHANGING
        system_directory     = lv_system_directory
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        OTHERS               = 4 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from GET_SYSTEM_DIRECTORY sy-subrc: { sy-subrc }| ).
    ENDIF.

    cl_gui_cfw=>flush( ).

    lv_exe_full_path = lv_system_directory && `\F12\IEChooser.exe`.

    cl_gui_frontend_services=>execute(
      EXPORTING
        application            = lv_exe_full_path
      EXCEPTIONS
        cntl_error             = 1
        error_no_gui           = 2
        bad_parameter          = 3
        file_not_found         = 4
        path_not_found         = 5
        file_extension_unknown = 6
        error_execute_failed   = 7
        synchronous_failed     = 8
        not_supported_by_gui   = 9
        OTHERS                 = 10 ).
    IF sy-subrc <> 0.
      " IEChooser is only available on Windows 10
      zcx_abapgit_exception=>raise( |Error from EXECUTE sy-subrc: { sy-subrc }| ).
    ENDIF.
  ENDMETHOD.