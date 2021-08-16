  METHOD zif_abapgit_object~deserialize.
* see function group SUSA

    DATA: lv_objectname TYPE trobj_name,
          ls_tobj       TYPE tobj,
          ls_tobjt      TYPE tobjt,
          ls_tobjvorflg TYPE tobjvorflg,
          lt_tactz      TYPE TABLE OF tactz,
          lt_tobjvordat TYPE TABLE OF tobjvordat,
          lt_tobjvor    TYPE TABLE OF tobjvor.


    ASSERT NOT ms_item-obj_name IS INITIAL.

    io_xml->read( EXPORTING iv_name = 'TOBJ'
                  CHANGING cg_data = ls_tobj ).
    ls_tobj-bname = sy-uname.
    io_xml->read( EXPORTING iv_name = 'TOBJT'
                  CHANGING cg_data = ls_tobjt ).
    io_xml->read( EXPORTING iv_name = 'TOBJVORFLG'
                  CHANGING cg_data = ls_tobjvorflg ).
    io_xml->read( EXPORTING iv_name = 'TACTZ'
                  CHANGING  cg_data = lt_tactz ).
    io_xml->read( EXPORTING iv_name = 'TOBJVORDAT'
                  CHANGING  cg_data = lt_tobjvordat ).
    io_xml->read( EXPORTING iv_name = 'TOBJVOR'
                  CHANGING  cg_data = lt_tobjvor ).

    tadir_insert( iv_package ).

    lv_objectname = mv_objectname.

    CALL FUNCTION 'SUSR_COMMEDITCHECK'
      EXPORTING
        objectname      = lv_objectname
        transobjecttype = 'O'.

    MODIFY tobj FROM ls_tobj.                             "#EC CI_SUBRC
    MODIFY tobjt FROM ls_tobjt.                           "#EC CI_SUBRC
    MODIFY tobjvorflg FROM ls_tobjvorflg.                 "#EC CI_SUBRC
    DELETE FROM tactz WHERE brobj = ms_item-obj_name.     "#EC CI_SUBRC
    INSERT tactz FROM TABLE lt_tactz.                     "#EC CI_SUBRC
    DELETE FROM tobjvordat WHERE objct = ms_item-obj_name. "#EC CI_SUBRC
    INSERT tobjvordat FROM TABLE lt_tobjvordat.           "#EC CI_SUBRC
    DELETE FROM tobjvor WHERE objct = ms_item-obj_name.   "#EC CI_SUBRC
    INSERT tobjvor FROM TABLE lt_tobjvor.                 "#EC CI_SUBRC

  ENDMETHOD.