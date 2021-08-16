  METHOD extract_field_values.

    FIELD-SYMBOLS: <ls_field> LIKE LINE OF it_fields.

    CLEAR: ev_url,
           ev_package,
           ev_branch,
           ev_display_name,
           ev_folder_logic,
           ev_ign_subpkg.

    READ TABLE it_fields INDEX 1 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_url = <ls_field>-value.

    READ TABLE it_fields INDEX 2 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_package = <ls_field>-value.
    TRANSLATE ev_package TO UPPER CASE.

    READ TABLE it_fields INDEX 3 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_branch = <ls_field>-value.

    READ TABLE it_fields INDEX 4 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_display_name = <ls_field>-value.

    READ TABLE it_fields INDEX 5 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_folder_logic = <ls_field>-value.
    TRANSLATE ev_folder_logic TO UPPER CASE.

    READ TABLE it_fields INDEX 6 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_ign_subpkg = <ls_field>-value.
    TRANSLATE ev_ign_subpkg TO UPPER CASE.

    READ TABLE it_fields INDEX 7 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    ev_master_lang_only = <ls_field>-value.

  ENDMETHOD.