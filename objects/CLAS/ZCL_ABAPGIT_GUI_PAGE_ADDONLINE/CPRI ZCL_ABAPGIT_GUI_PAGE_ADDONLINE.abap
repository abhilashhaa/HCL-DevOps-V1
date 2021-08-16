  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_id,
        url                TYPE string VALUE 'url',
        package            TYPE string VALUE 'package',
        branch_name        TYPE string VALUE 'branch_name',
        display_name       TYPE string VALUE 'display_name',
        folder_logic       TYPE string VALUE 'folder_logic',
        ignore_subpackages TYPE string VALUE 'ignore_subpackages',
        master_lang_only   TYPE string VALUE 'master_lang_only',
      END OF c_id.

    CONSTANTS:
      BEGIN OF c_event,
        go_back         TYPE string VALUE 'go-back',
        choose_package  TYPE string VALUE 'choose-package',
        create_package  TYPE string VALUE 'create-package',
        choose_branch   TYPE string VALUE 'choose-branch',
        add_online_repo TYPE string VALUE 'add-repo-online',
      END OF c_event.

    DATA mo_validation_log TYPE REF TO zcl_abapgit_string_map.
    DATA mo_form_data TYPE REF TO zcl_abapgit_string_map.
    DATA mo_form TYPE REF TO zcl_abapgit_html_form.

    METHODS parse_form
      IMPORTING
        it_form_fields TYPE tihttpnvp
      RETURNING
        VALUE(ro_form_data) TYPE REF TO zcl_abapgit_string_map
      RAISING
        zcx_abapgit_exception.

    METHODS validate_form
      IMPORTING
        io_form_data             TYPE REF TO zcl_abapgit_string_map
      RETURNING
        VALUE(ro_validation_log) TYPE REF TO zcl_abapgit_string_map
      RAISING
        zcx_abapgit_exception.

    METHODS get_form_schema
      RETURNING
        VALUE(ro_form) TYPE REF TO zcl_abapgit_html_form.
