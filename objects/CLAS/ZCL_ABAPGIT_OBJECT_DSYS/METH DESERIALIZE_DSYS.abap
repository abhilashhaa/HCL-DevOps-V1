  METHOD deserialize_dsys.

    DATA: ls_data      TYPE ty_data,
          ls_docu_info TYPE dokil,
          lv_version   TYPE dokvers,
          lv_doku_obj  TYPE doku_obj.

    lv_doku_obj = mv_doc_object.
    ii_xml->read( EXPORTING iv_name = 'DSYS'
                  CHANGING cg_data = ls_data ).

    CALL FUNCTION 'DOCU_INIT'
      EXPORTING
        id     = c_id
        langu  = mv_language
        object = lv_doku_obj
        typ    = c_typ
      IMPORTING
        xdokil = ls_docu_info.

    lv_version = ls_docu_info-version.

    CALL FUNCTION 'DOCU_UPDATE'
      EXPORTING
        head    = ls_data-head
        state   = 'A'
        typ     = c_typ
        version = lv_version
      TABLES
        line    = ls_data-lines.

  ENDMETHOD.