  METHOD zif_abapgit_object~serialize.

    DATA: ls_objh     TYPE objh,
          ls_objt     TYPE objt,
          lt_objs     TYPE tt_objs,
          lt_objsl    TYPE tt_objsl,
          lt_objm     TYPE tt_objm,
          ls_tobj     TYPE ty_tobj,
          lv_type_pos TYPE i.

    lv_type_pos = strlen( ms_item-obj_name ) - 1.

    ls_objh-objectname = ms_item-obj_name(lv_type_pos).
    ls_objh-objecttype = ms_item-obj_name+lv_type_pos.

    CALL FUNCTION 'CTO_OBJECT_GET'
      EXPORTING
        iv_objectname      = ls_objh-objectname
        iv_objecttype      = ls_objh-objecttype
        iv_language        = mv_language
        iv_sel_objt        = abap_true
        iv_sel_objs        = abap_true
        iv_sel_objsl       = abap_true
        iv_sel_objm        = abap_true
      IMPORTING
        es_objh            = ls_objh
        es_objt            = ls_objt
      TABLES
        tt_objs            = lt_objs
        tt_objsl           = lt_objsl
        tt_objm            = lt_objm
      EXCEPTIONS
        object_not_defined = 1
        OTHERS             = 2.
    IF sy-subrc = 1.
      RETURN.
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from CTO_OBJECT_GET' ).
    ENDIF.

    CLEAR: ls_objh-luser,
           ls_objh-ldate.

    io_xml->add( iv_name = 'OBJH'
                 ig_data = ls_objh ).
    io_xml->add( iv_name = 'OBJT'
                 ig_data = ls_objt ).
    io_xml->add( iv_name = 'OBJS'
                 ig_data = lt_objs ).
    io_xml->add( iv_name = 'OBJSL'
                 ig_data = lt_objsl ).
    io_xml->add( iv_name = 'OBJM'
                 ig_data = lt_objm ).

    ls_tobj = read_extra( ls_objh-objectname ).

    io_xml->add( iv_name = 'TOBJ'
                 ig_data = ls_tobj ).

  ENDMETHOD.