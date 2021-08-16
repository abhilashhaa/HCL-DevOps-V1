  METHOD check_duplicates.

    DATA: lt_files          TYPE zif_abapgit_definitions=>ty_files_tt,
          lv_path           TYPE string,
          lv_filename       TYPE string,
          lt_duplicates     TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
          lv_duplicates     LIKE LINE OF lt_duplicates,
          lv_all_duplicates TYPE string.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF it_files.

    lt_files = it_files.
    SORT lt_files BY path ASCENDING filename ASCENDING.

    LOOP AT lt_files ASSIGNING <ls_file>.
      IF lv_path = <ls_file>-path AND lv_filename = <ls_file>-filename.
        CONCATENATE <ls_file>-path <ls_file>-filename INTO lv_duplicates.
        APPEND lv_duplicates TO lt_duplicates.
      ENDIF.
      lv_path = <ls_file>-path.
      lv_filename = <ls_file>-filename.
    ENDLOOP.

    IF lt_duplicates IS NOT INITIAL.
      CONCATENATE LINES OF lt_duplicates INTO lv_all_duplicates SEPARATED BY `, `.
      zcx_abapgit_exception=>raise( |Duplicates: { lv_all_duplicates }| ).
    ENDIF.

  ENDMETHOD.