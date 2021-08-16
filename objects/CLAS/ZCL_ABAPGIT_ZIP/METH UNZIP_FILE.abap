  METHOD unzip_file.

    DATA: lo_zip  TYPE REF TO cl_abap_zip,
          lv_data TYPE xstring.

    FIELD-SYMBOLS: <ls_zipfile> LIKE LINE OF lo_zip->files,
                   <ls_file>    LIKE LINE OF rt_files.


    CREATE OBJECT lo_zip.
    lo_zip->load( EXPORTING
                    zip             = iv_xstr
                  EXCEPTIONS
                    zip_parse_error = 1
                    OTHERS          = 2 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from zip' ).
    ENDIF.

    LOOP AT lo_zip->files ASSIGNING <ls_zipfile>.

      lo_zip->get(
        EXPORTING
          name                    = <ls_zipfile>-name
        IMPORTING
          content                 = lv_data
        EXCEPTIONS
          zip_index_error         = 1
          zip_decompression_error = 2
          OTHERS                  = 3 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from zip get' ).
      ENDIF.

      APPEND INITIAL LINE TO rt_files ASSIGNING <ls_file>.

      filename(
        EXPORTING
          iv_str      = <ls_zipfile>-name
        IMPORTING
          ev_path     = <ls_file>-path
          ev_filename = <ls_file>-filename ).

      <ls_file>-data = lv_data.

      <ls_file>-sha1 = zcl_abapgit_hash=>sha1( iv_type = zif_abapgit_definitions=>c_type-blob
                                               iv_data = <ls_file>-data ).

    ENDLOOP.

    DELETE rt_files WHERE filename IS INITIAL.

    normalize_path( CHANGING ct_files = rt_files ).

  ENDMETHOD.