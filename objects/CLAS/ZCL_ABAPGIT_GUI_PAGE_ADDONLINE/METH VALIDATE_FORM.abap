  METHOD validate_form.

    DATA lx_err TYPE REF TO zcx_abapgit_exception.

    CREATE OBJECT ro_validation_log.

    IF io_form_data->get( c_id-url ) IS INITIAL.
      ro_validation_log->set(
        iv_key = c_id-url
        iv_val = 'Url cannot be empty' ).
    ELSE.
      TRY.
          zcl_abapgit_url=>validate( io_form_data->get( c_id-url ) ).
        CATCH zcx_abapgit_exception INTO lx_err.
          ro_validation_log->set(
            iv_key = c_id-url
            iv_val = lx_err->get_text( ) ).
      ENDTRY.
    ENDIF.

    IF io_form_data->get( c_id-package ) IS INITIAL.
      ro_validation_log->set(
        iv_key = c_id-package
        iv_val = 'Package cannot be empty' ).
    ELSE.
      TRY.
          zcl_abapgit_repo_srv=>get_instance( )->validate_package(
            iv_package    = |{ io_form_data->get( c_id-package ) }|
            iv_ign_subpkg = |{ io_form_data->get( c_id-ignore_subpackages ) }| ).
        CATCH zcx_abapgit_exception INTO lx_err.
          ro_validation_log->set(
            iv_key = c_id-package
            iv_val = lx_err->get_text( ) ).
      ENDTRY.
    ENDIF.

    IF io_form_data->get( c_id-folder_logic ) <> zif_abapgit_dot_abapgit=>c_folder_logic-prefix
        AND io_form_data->get( c_id-folder_logic ) <> zif_abapgit_dot_abapgit=>c_folder_logic-full.
      ro_validation_log->set(
        iv_key = c_id-folder_logic
        iv_val = |Invalid folder logic { io_form_data->get( c_id-folder_logic )
        }. Must be { zif_abapgit_dot_abapgit=>c_folder_logic-prefix
        } or { zif_abapgit_dot_abapgit=>c_folder_logic-full } | ).
    ENDIF.

  ENDMETHOD.