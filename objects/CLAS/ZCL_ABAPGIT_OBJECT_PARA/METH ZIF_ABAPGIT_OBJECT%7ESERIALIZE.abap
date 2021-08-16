  METHOD zif_abapgit_object~serialize.

    DATA: ls_tpara  TYPE tpara,
          ls_tparat TYPE tparat.


    SELECT SINGLE * FROM tpara INTO ls_tpara
      WHERE paramid = ms_item-obj_name.                 "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM tparat INTO ls_tparat
      WHERE paramid = ms_item-obj_name
      AND sprache = mv_language.          "#EC CI_GENBUFF "#EC CI_SUBRC

    io_xml->add( iv_name = 'TPARA'
                 ig_data = ls_tpara ).
    io_xml->add( iv_name = 'TPARAT'
                 ig_data = ls_tparat ).

  ENDMETHOD.