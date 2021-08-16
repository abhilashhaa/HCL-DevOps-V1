  METHOD zif_abapgit_object~deserialize.

    DATA: ls_style TYPE ty_style.


    io_xml->read( EXPORTING iv_name = 'STYLE'
                  CHANGING cg_data = ls_style ).

    CALL FUNCTION 'SAVE_STYLE'
      EXPORTING
        style_header = ls_style-header
      TABLES
        paragraphs   = ls_style-paragraphs
        strings      = ls_style-strings
        tabs         = ls_style-tabs.

    tadir_insert( iv_package ).

  ENDMETHOD.