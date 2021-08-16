  METHOD get_where_used_recursive.

    DATA: lt_findstrings TYPE string_table,
          lt_founds      TYPE STANDARD TABLE OF rsfindlst,
          lt_scope       TYPE tty_seu_obj,
          lv_findstring  LIKE LINE OF lt_findstrings.

    FIELD-SYMBOLS: <ls_found> TYPE rsfindlst.

    lt_scope = it_scope.

    lv_findstring = iv_object_name.
    INSERT lv_findstring INTO TABLE lt_findstrings.

    DO iv_depth TIMES.

      CLEAR: lt_founds.

      CALL FUNCTION 'RS_EU_CROSSREF'
        EXPORTING
          i_find_obj_cls           = iv_object_type
          no_dialog                = 'X'
        TABLES
          i_findstrings            = lt_findstrings
          o_founds                 = lt_founds
          i_scope_object_cls       = lt_scope
        EXCEPTIONS
          not_executed             = 1
          not_found                = 2
          illegal_object           = 3
          no_cross_for_this_object = 4
          batch                    = 5
          batchjob_error           = 6
          wrong_type               = 7
          object_not_exist         = 8
          OTHERS                   = 9.

      IF sy-subrc = 1 OR sy-subrc = 2 OR lines( lt_founds ) = 0.
        EXIT.
      ELSEIF sy-subrc > 2.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

      INSERT LINES OF lt_founds INTO TABLE rt_founds_all.

      CLEAR: lt_findstrings.

      LOOP AT lt_founds ASSIGNING <ls_found>.

        lv_findstring = <ls_found>-object.
        INSERT lv_findstring INTO TABLE lt_findstrings.

      ENDLOOP.

    ENDDO.

  ENDMETHOD.