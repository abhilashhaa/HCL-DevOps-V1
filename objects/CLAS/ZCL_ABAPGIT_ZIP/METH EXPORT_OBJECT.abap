  METHOD export_object.

    DATA: ls_tadir      TYPE zif_abapgit_definitions=>ty_tadir,
          lv_folder     TYPE string,
          lv_fullpath   TYPE string,
          lv_sep        TYPE c LENGTH 1,
          ls_files_item TYPE zcl_abapgit_objects=>ty_serialization.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF ls_files_item-files.

    WHILE ls_tadir IS INITIAL.

      ls_tadir = zcl_abapgit_ui_factory=>get_popups( )->popup_object( ).
      IF ls_tadir IS INITIAL.
        MESSAGE 'Object couldn''t be found' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.

    ENDWHILE.

    ls_files_item-item-obj_type = ls_tadir-object.
    ls_files_item-item-obj_name = ls_tadir-obj_name.

    ls_files_item = zcl_abapgit_objects=>serialize( is_item = ls_files_item-item
                                                    iv_language = sy-langu ).

    IF lines( ls_files_item-files ) = 0.
      MESSAGE 'Empty' TYPE 'S'.
      RETURN.
    ENDIF.

    cl_gui_frontend_services=>directory_browse(
      EXPORTING
        initial_folder  = gv_prev
      CHANGING
        selected_folder = lv_folder ).
    IF lv_folder IS INITIAL.
      RETURN.
    ENDIF.

    gv_prev = lv_folder.

    cl_gui_frontend_services=>get_file_separator( CHANGING file_separator = lv_sep ).

    LOOP AT ls_files_item-files ASSIGNING <ls_file>.
      CONCATENATE lv_folder lv_sep <ls_file>-filename INTO lv_fullpath.

      save_binstring_to_localfile( iv_filename = lv_fullpath
                                   iv_binstring = <ls_file>-data ).

    ENDLOOP.

  ENDMETHOD.