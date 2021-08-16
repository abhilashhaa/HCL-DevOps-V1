  METHOD zif_abapgit_object~serialize.

    DATA: ls_tobj       TYPE tobj,
          ls_tobjt      TYPE tobjt,
          ls_tobjvorflg TYPE tobjvorflg,
          lt_tactz      TYPE TABLE OF tactz,
          lt_tobjvordat TYPE TABLE OF tobjvordat,
          lt_tobjvor    TYPE TABLE OF tobjvor.


    SELECT SINGLE * FROM tobj INTO ls_tobj
      WHERE objct = ms_item-obj_name.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    CLEAR ls_tobj-bname.

    SELECT SINGLE * FROM tobjt INTO ls_tobjt
      WHERE object = ms_item-obj_name
      AND langu = mv_language.                          "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'TOBJT no english description'
        && ' for object (' && ms_item-obj_name && ')' ).
    ENDIF.

    SELECT SINGLE * FROM tobjvorflg INTO ls_tobjvorflg
      WHERE objct = ms_item-obj_name.                     "#EC CI_SUBRC

    SELECT * FROM tactz INTO TABLE lt_tactz
      WHERE brobj = ms_item-obj_name
      ORDER BY PRIMARY KEY.               "#EC CI_SUBRC "#EC CI_GENBUFF

    SELECT * FROM tobjvordat INTO TABLE lt_tobjvordat
      WHERE objct = ms_item-obj_name
      ORDER BY PRIMARY KEY.               "#EC CI_SUBRC "#EC CI_GENBUFF

    SELECT * FROM tobjvor INTO TABLE lt_tobjvor
      WHERE objct = ms_item-obj_name
      ORDER BY PRIMARY KEY.                               "#EC CI_SUBRC

    io_xml->add( iv_name = 'TOBJ'
                 ig_data = ls_tobj ).
    io_xml->add( iv_name = 'TOBJT'
                 ig_data = ls_tobjt ).
    io_xml->add( iv_name = 'TOBJVORFLG'
                 ig_data = ls_tobjvorflg ).
    io_xml->add( ig_data = lt_tactz
                 iv_name = 'TACTZ' ).
    io_xml->add( ig_data = lt_tobjvordat
                 iv_name = 'TOBJVORDAT' ).
    io_xml->add( ig_data = lt_tobjvor
                 iv_name = 'TOBJVOR' ).

  ENDMETHOD.