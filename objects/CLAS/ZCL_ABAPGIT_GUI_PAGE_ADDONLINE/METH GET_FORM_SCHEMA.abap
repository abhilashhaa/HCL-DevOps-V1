  METHOD get_form_schema.

    ro_form = zcl_abapgit_html_form=>create( iv_form_id = 'add-repo-online-form' ).
    ro_form->text(
      iv_name        = c_id-url
      iv_required    = abap_true
      iv_label       = 'Git repository URL'
      iv_hint        = 'HTTPS address of the repository to clone'
      iv_placeholder = 'https://github.com/...git' ).
    ro_form->text(
      iv_name        = c_id-package
      iv_side_action = c_event-choose_package
      iv_required    = abap_true
      iv_upper_case  = abap_true
      iv_label       = 'Package'
      iv_hint        = 'SAP package for the code (should be a dedicated one)'
      iv_placeholder = 'Z... / $...' ).
    ro_form->text(
      iv_name        = c_id-branch_name
      iv_side_action = c_event-choose_branch
      iv_label       = 'Branch'
      iv_hint        = 'Switch to a specific branch on clone (default: master)'
      iv_placeholder = 'master' ).
    ro_form->radio(
      iv_name        = c_id-folder_logic
      iv_default_value = zif_abapgit_dot_abapgit=>c_folder_logic-prefix
      iv_label       = 'Folder logic'
      iv_hint        = 'Define how package folders are named in the repo (see https://docs.abapgit.org)' ).
    ro_form->option(
      iv_label       = 'Prefix'
      iv_value       = zif_abapgit_dot_abapgit=>c_folder_logic-prefix ).
    ro_form->option(
      iv_label       = 'Full'
      iv_value       = zif_abapgit_dot_abapgit=>c_folder_logic-full ).
    ro_form->text(
      iv_name        = c_id-display_name
      iv_label       = 'Display name'
      iv_hint        = 'Name to show instead of original repo name (optional)' ).
    ro_form->checkbox(
      iv_name        = c_id-ignore_subpackages
      iv_label       = 'Ignore subpackages'
      iv_hint        = 'Syncronize root package only (see https://docs.abapgit.org)' ).
    ro_form->checkbox(
      iv_name        = c_id-master_lang_only
      iv_label       = 'Serialize master language only'
      iv_hint        = 'Ignore translations, serialize just master language' ).
    ro_form->command(
      iv_label       = 'Clone online repo'
      iv_is_main     = abap_true
      iv_action      = c_event-add_online_repo ).
    ro_form->command(
      iv_label       = 'Create package'
      iv_action      = c_event-create_package ).
    ro_form->command(
      iv_label       = 'Back'
      iv_action      = c_event-go_back ).

  ENDMETHOD.