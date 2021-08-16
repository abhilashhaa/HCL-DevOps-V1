  METHOD read_tadir_sicf.

* note: this method is called dynamically from some places

    DATA: lt_tadir    TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lv_hash     TYPE ty_hash,
          lv_obj_name TYPE tadir-obj_name.

    FIELD-SYMBOLS: <ls_tadir> LIKE LINE OF lt_tadir.


    lv_hash = iv_obj_name+15.
    CONCATENATE iv_obj_name(15) '%' INTO lv_obj_name.

    SELECT * FROM tadir INTO CORRESPONDING FIELDS OF TABLE lt_tadir
      WHERE pgmid = iv_pgmid
      AND object = 'SICF'
      AND obj_name LIKE lv_obj_name
      ORDER BY PRIMARY KEY ##TOO_MANY_ITAB_FIELDS. "#EC CI_GENBUFF

    LOOP AT lt_tadir ASSIGNING <ls_tadir>.
      IF read_sicf_url( <ls_tadir>-obj_name ) = lv_hash.
        rs_tadir = <ls_tadir>.
        RETURN.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.