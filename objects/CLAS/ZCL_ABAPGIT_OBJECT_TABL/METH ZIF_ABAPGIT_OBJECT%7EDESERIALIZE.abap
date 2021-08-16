  METHOD zif_abapgit_object~deserialize.

    DATA: lv_name      TYPE ddobjname,
          lv_tname     TYPE trobj_name,
          ls_dd02v     TYPE dd02v,
          ls_dd09l     TYPE dd09l,
          lt_dd03p     TYPE TABLE OF dd03p,
          lt_dd05m     TYPE TABLE OF dd05m,
          lt_dd08v     TYPE TABLE OF dd08v,
          lt_dd12v     TYPE dd12vtab,
          lt_dd17v     TYPE dd17vtab,
          ls_dd17v     LIKE LINE OF lt_dd17v,
          lt_secondary LIKE lt_dd17v,
          lt_dd35v     TYPE TABLE OF dd35v,
          lt_dd36m     TYPE dd36mttyp,
          ls_dd12v     LIKE LINE OF lt_dd12v,
          lv_refs      TYPE abap_bool,
          ls_extras    TYPE ty_tabl_extras.

    FIELD-SYMBOLS: <ls_dd03p> TYPE dd03p.

    IF deserialize_idoc_segment( io_xml     = io_xml
                                 iv_package = iv_package ) = abap_false.

      io_xml->read( EXPORTING iv_name = 'DD02V'
                    CHANGING cg_data = ls_dd02v ).
      io_xml->read( EXPORTING iv_name = 'DD09L'
                    CHANGING cg_data = ls_dd09l ).
      io_xml->read( EXPORTING iv_name  = 'DD03P_TABLE'
                    CHANGING cg_data = lt_dd03p ).

      " DDIC Step: Replace REF TO class/interface with generic reference to avoid cyclic dependency
      LOOP AT lt_dd03p ASSIGNING <ls_dd03p> WHERE datatype = 'REF'.
        IF iv_step = zif_abapgit_object=>gc_step_id-ddic.
          <ls_dd03p>-rollname = 'OBJECT'.
        ELSE.
          lv_refs = abap_true.
        ENDIF.
      ENDLOOP.

      io_xml->read( EXPORTING iv_name = 'DD05M_TABLE'
                    CHANGING cg_data = lt_dd05m ).
      io_xml->read( EXPORTING iv_name = 'DD08V_TABLE'
                    CHANGING cg_data = lt_dd08v ).
      io_xml->read( EXPORTING iv_name = 'DD12V'
                    CHANGING cg_data = lt_dd12v ).
      io_xml->read( EXPORTING iv_name = 'DD17V'
                    CHANGING cg_data = lt_dd17v ).
      io_xml->read( EXPORTING iv_name = 'DD35V_TALE'
                    CHANGING cg_data = lt_dd35v ).
      io_xml->read( EXPORTING iv_name = 'DD36M'
                    CHANGING cg_data = lt_dd36m ).

      " DDIC Step: Remove references to search helps and foreign keys
      IF iv_step = zif_abapgit_object=>gc_step_id-ddic.
        CLEAR: lt_dd08v, lt_dd35v, lt_dd36m.
      ENDIF.

      IF iv_step = zif_abapgit_object=>gc_step_id-late AND lv_refs = abap_false
        AND lines( lt_dd35v ) = 0 AND lines( lt_dd08v ) = 0.
        RETURN. " already active
      ENDIF.

      corr_insert( iv_package = iv_package
                   ig_object_class = 'DICT' ).

      lv_name = ms_item-obj_name. " type conversion

      CALL FUNCTION 'DDIF_TABL_PUT'
        EXPORTING
          name              = lv_name
          dd02v_wa          = ls_dd02v
          dd09l_wa          = ls_dd09l
        TABLES
          dd03p_tab         = lt_dd03p
          dd05m_tab         = lt_dd05m
          dd08v_tab         = lt_dd08v
          dd35v_tab         = lt_dd35v
          dd36m_tab         = lt_dd36m
        EXCEPTIONS
          tabl_not_found    = 1
          name_inconsistent = 2
          tabl_inconsistent = 3
          put_failure       = 4
          put_refused       = 5
          OTHERS            = 6.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from DDIF_TABL_PUT' ).
      ENDIF.

      zcl_abapgit_objects_activation=>add_item( ms_item ).

* handle indexes
      LOOP AT lt_dd12v INTO ls_dd12v.

* todo, call corr_insert?

        CLEAR lt_secondary.
        LOOP AT lt_dd17v INTO ls_dd17v
            WHERE sqltab = ls_dd12v-sqltab AND indexname = ls_dd12v-indexname.
          APPEND ls_dd17v TO lt_secondary.
        ENDLOOP.

        CALL FUNCTION 'DDIF_INDX_PUT'
          EXPORTING
            name              = ls_dd12v-sqltab
            id                = ls_dd12v-indexname
            dd12v_wa          = ls_dd12v
          TABLES
            dd17v_tab         = lt_secondary
          EXCEPTIONS
            indx_not_found    = 1
            name_inconsistent = 2
            indx_inconsistent = 3
            put_failure       = 4
            put_refused       = 5
            OTHERS            = 6.
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( 'error from DDIF_INDX_PUT' ).
        ENDIF.

        CALL FUNCTION 'DD_DD_TO_E071'
          EXPORTING
            type     = 'INDX'
            name     = ls_dd12v-sqltab
            id       = ls_dd12v-indexname
          IMPORTING
            obj_name = lv_tname.

        zcl_abapgit_objects_activation=>add( iv_type = 'INDX'
                                             iv_name = lv_tname ).

      ENDLOOP.

      deserialize_texts( io_xml   = io_xml
                         is_dd02v = ls_dd02v ).

      deserialize_longtexts( io_xml ).

      io_xml->read( EXPORTING iv_name = c_s_dataname-tabl_extras
                    CHANGING cg_data = ls_extras ).
      update_extras( iv_tabname     = lv_name
                     is_tabl_extras = ls_extras ).

    ENDIF.

  ENDMETHOD.