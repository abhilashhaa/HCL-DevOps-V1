  METHOD export_package.

    DATA: lo_repo   TYPE REF TO zcl_abapgit_repo_offline,
          ls_data   TYPE zif_abapgit_persistence=>ty_repo,
          li_popups TYPE REF TO zif_abapgit_popups.

    DATA lv_serialize_master_lang_only TYPE abap_bool.

    ls_data-key = 'DUMMY'.
    ls_data-dot_abapgit = zcl_abapgit_dot_abapgit=>build_default( )->get_data( ).

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    li_popups->popup_package_export(
      IMPORTING
        ev_package      = ls_data-package
        ev_folder_logic = ls_data-dot_abapgit-folder_logic
        ev_serialize_master_lang_only = lv_serialize_master_lang_only ).
    IF ls_data-package IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    ls_data-local_settings-serialize_master_lang_only = lv_serialize_master_lang_only.

    CREATE OBJECT lo_repo
      EXPORTING
        is_data = ls_data.

    ev_xstr = export( lo_repo ).
    ev_package = ls_data-package.

  ENDMETHOD.