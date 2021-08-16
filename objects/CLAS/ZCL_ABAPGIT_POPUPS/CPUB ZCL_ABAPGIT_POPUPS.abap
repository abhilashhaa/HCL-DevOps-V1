CLASS zcl_abapgit_popups DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_abapgit_ui_factory.

  PUBLIC SECTION.
    CONSTANTS: c_default_column TYPE lvc_fname VALUE `DEFAULT_COLUMN` ##NO_TEXT.

    INTERFACES: zif_abapgit_popups.
    ALIASES:
      popup_package_export          FOR zif_abapgit_popups~popup_package_export,
      popup_folder_logic            FOR zif_abapgit_popups~popup_folder_logic,
      popup_object                  FOR zif_abapgit_popups~popup_object,
      create_branch_popup           FOR zif_abapgit_popups~create_branch_popup,
      repo_new_offline              FOR zif_abapgit_popups~repo_new_offline,
      branch_list_popup             FOR zif_abapgit_popups~branch_list_popup,
      repo_popup                    FOR zif_abapgit_popups~repo_popup,
      popup_to_confirm              FOR zif_abapgit_popups~popup_to_confirm,
      popup_to_inform               FOR zif_abapgit_popups~popup_to_inform,
      popup_to_create_package       FOR zif_abapgit_popups~popup_to_create_package,
      popup_to_create_transp_branch FOR zif_abapgit_popups~popup_to_create_transp_branch,
      popup_to_select_transports    FOR zif_abapgit_popups~popup_to_select_transports,
      popup_to_select_from_list     FOR zif_abapgit_popups~popup_to_select_from_list,
      branch_popup_callback         FOR zif_abapgit_popups~branch_popup_callback,
      package_popup_callback        FOR zif_abapgit_popups~package_popup_callback,
      popup_transport_request       FOR zif_abapgit_popups~popup_transport_request,
      popup_proxy_bypass            FOR zif_abapgit_popups~popup_proxy_bypass.
