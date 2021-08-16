  METHOD zif_abapgit_object~deserialize.

    DATA: ls_objh  TYPE objh,
          ls_objt  TYPE objt,
          lt_objs  TYPE tt_objs,
          lt_objsl TYPE tt_objsl,
          lt_objm  TYPE tt_objm,
          ls_tobj  TYPE ty_tobj.


    io_xml->read( EXPORTING iv_name = 'OBJH'
                  CHANGING cg_data = ls_objh ).
    io_xml->read( EXPORTING iv_name = 'OBJT'
                  CHANGING cg_data = ls_objt ).
    io_xml->read( EXPORTING iv_name = 'OBJS'
                  CHANGING cg_data = lt_objs ).
    io_xml->read( EXPORTING iv_name = 'OBJSL'
                  CHANGING cg_data = lt_objsl ).
    io_xml->read( EXPORTING iv_name = 'OBJM'
                  CHANGING cg_data = lt_objm ).

    CALL FUNCTION 'OBJ_GENERATE'
      EXPORTING
        iv_objectname         = ls_objh-objectname
        iv_objecttype         = ls_objh-objecttype
        iv_maint_mode         = 'I'
        iv_objecttext         = ls_objt-ddtext
        iv_objcateg           = ls_objh-objcateg
        iv_objtransp          = ls_objh-objtransp
        iv_devclass           = iv_package
      TABLES
        tt_v_obj_s            = lt_objs
        tt_objm               = lt_objm
      EXCEPTIONS
        illegal_call          = 1
        object_not_found      = 2
        generate_error        = 3
        transport_error       = 4
        object_enqueue_failed = 5
        OTHERS                = 6.
    IF sy-subrc <> 0.
* TOBJ has to be saved/generated after the DDIC tables have been
* activated - fixed with late deserialization
      zcx_abapgit_exception=>raise( 'error from OBJ_GENERATE' ).
    ENDIF.

    CALL FUNCTION 'OBJ_SET_IMPORTABLE'
      EXPORTING
        iv_objectname         = ls_objh-objectname
        iv_objecttype         = ls_objh-objecttype
        iv_importable         = ls_objh-importable
      EXCEPTIONS
        object_not_defined    = 1
        invalid               = 2
        transport_error       = 3
        object_enqueue_failed = 4
        OTHERS                = 5.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from OBJ_SET_IMPORTABLE' ).
    ENDIF.

* fm OBJ_GENERATE takes the defaults from the DDIC object
* set OBJTRANSP directly, should be okay looking at the code in OBJ_SET_IMPORTABLE
* locking has been done in OBJ_SET_IMPORTABLE plus recording of transport
    UPDATE objh SET objtransp = ls_objh-objtransp
      WHERE objectname = ls_objh-objectname
      AND objecttype = ls_objh-objecttype.

    io_xml->read( EXPORTING iv_name = 'TOBJ'
                  CHANGING cg_data = ls_tobj ).
    ls_tobj-tvdir-gendate = sy-datum.
    ls_tobj-tvdir-gentime = sy-uzeit.
    ls_tobj-tvdir-devclass = iv_package.

    update_extra( ls_tobj ).

  ENDMETHOD.