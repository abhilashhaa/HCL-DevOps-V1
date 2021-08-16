  METHOD encode_files.

    DATA: lo_zip      TYPE REF TO cl_abap_zip,
          lv_filename TYPE string.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF it_files.


    CREATE OBJECT lo_zip.

    LOOP AT it_files ASSIGNING <ls_file>.
      CONCATENATE <ls_file>-file-path+1 <ls_file>-file-filename INTO lv_filename.
      lo_zip->add( name    = lv_filename
                   content = <ls_file>-file-data ).
    ENDLOOP.

    rv_xstr = lo_zip->save( ).

  ENDMETHOD.