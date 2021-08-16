  METHOD save_local_settings.

    DATA: ls_settings      TYPE zif_abapgit_persistence=>ty_repo-local_settings,
          ls_post_field    LIKE LINE OF it_post_fields,
          lv_check_variant TYPE sci_chkv.


    ls_settings = mo_repo->get_local_settings( ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'display_name'.
    ASSERT sy-subrc = 0.
    ls_settings-display_name = ls_post_field-value.

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'write_protected' value = 'on'.
    ls_settings-write_protected = boolc( sy-subrc = 0 ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'ignore_subpackages' value = 'on'.
    ls_settings-ignore_subpackages = boolc( sy-subrc = 0 ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'only_local_objects' value = 'on'.
    ls_settings-only_local_objects = boolc( sy-subrc = 0 ).

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'check_variant'.
    ASSERT sy-subrc = 0.
    lv_check_variant = to_upper( ls_post_field-value ).
    IF ls_post_field-value IS NOT INITIAL.
      zcl_abapgit_code_inspector=>validate_check_variant( lv_check_variant ).
    ENDIF.
    ls_settings-code_inspector_check_variant = lv_check_variant.

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'block_commit' value = 'on'.
    ls_settings-block_commit = boolc( sy-subrc = 0 ).

    IF ls_settings-block_commit = abap_true
        AND ls_settings-code_inspector_check_variant IS INITIAL.
      zcx_abapgit_exception=>raise( |If block commit is active, a check variant has to be maintained.| ).
    ENDIF.

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'serialize_master_lang_only' value = 'on'.
    ls_settings-serialize_master_lang_only = boolc( sy-subrc = 0 ).

    mo_repo->set_local_settings( ls_settings ).

  ENDMETHOD.