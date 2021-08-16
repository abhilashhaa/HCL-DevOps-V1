  METHOD zif_abapgit_object~serialize.

    DATA: ls_extension TYPE ty_extension.

    CALL FUNCTION 'STREE_EXTENSION_EXISTS'
      EXPORTING
        extension        = mv_extension
      IMPORTING
        extension_header = ls_extension-header.

    SELECT * FROM ttree_extt
             INTO TABLE ls_extension-texts
             WHERE extension = mv_extension ORDER BY PRIMARY KEY.

    SELECT * FROM ttrees
            INTO TABLE ls_extension-sequences
            WHERE extension = mv_extension ORDER BY PRIMARY KEY.

    io_xml->add( iv_name = 'SHI5'
                 ig_data = ls_extension ).

  ENDMETHOD.