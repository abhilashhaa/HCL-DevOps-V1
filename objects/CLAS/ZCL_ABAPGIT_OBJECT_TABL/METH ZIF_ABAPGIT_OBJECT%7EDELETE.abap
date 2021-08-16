  METHOD zif_abapgit_object~delete.

    DATA: lv_objname  TYPE rsedd0-ddobjname,
          lv_tabclass TYPE dd02l-tabclass,
          lv_no_ask   TYPE abap_bool,
          lv_subrc    TYPE sy-subrc,
          lr_data     TYPE REF TO data.

    FIELD-SYMBOLS: <lg_data>  TYPE any.

    IF zif_abapgit_object~exists( ) = abap_false.
      " Proxies e.g. delete on its own, nothing todo here then.
      RETURN.
    ENDIF.

    lv_objname = ms_item-obj_name.

    IF delete_idoc_segment( ) = abap_false.

      lv_no_ask = abap_true.
      SELECT SINGLE tabclass FROM dd02l INTO lv_tabclass
        WHERE tabname = ms_item-obj_name
        AND as4local = 'A'
        AND as4vers = '0000'.
      IF sy-subrc = 0 AND lv_tabclass = 'TRANSP'.

        " Avoid dump in dynamic SELECT in case the table does not exist on database
        CALL FUNCTION 'DB_EXISTS_TABLE'
          EXPORTING
            tabname = lv_objname
          IMPORTING
            subrc   = lv_subrc.
        IF lv_subrc = 0.
          " it cannot delete table with data without asking
          CREATE DATA lr_data TYPE (lv_objname).
          ASSIGN lr_data->* TO <lg_data>.
          SELECT SINGLE * FROM (lv_objname) INTO <lg_data>.
          IF sy-subrc = 0.
            lv_no_ask = abap_false.
          ENDIF.
        ENDIF.
      ENDIF.

      delete_ddic( iv_objtype = 'T'
                   iv_no_ask  = lv_no_ask ).

      delete_longtexts( c_longtext_id_tabl ).

      delete_extras( iv_tabname = lv_objname ).

    ENDIF.

  ENDMETHOD.