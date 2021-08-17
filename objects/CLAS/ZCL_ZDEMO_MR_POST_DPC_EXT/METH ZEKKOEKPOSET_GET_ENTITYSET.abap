  METHOD zekkoekposet_get_entityset.
*--------------------------------------------------------------------*
* Types and Data Definition
*--------------------------------------------------------------------*

* Define local range type for bukrs
    TYPES : tr_bukrs  TYPE RANGE OF bukrs .
    TYPES : tr_matnr  TYPE RANGE OF matnr .

* Define local line type to access lines of range type
    TYPES : ty_matnr  TYPE LINE  OF tr_matnr.
    TYPES : ty_bukrs  TYPE LINE  OF tr_bukrs.


* Define range table and work area
    DATA : workarea_bukrs    TYPE ty_bukrs,
           workarea_matnr    TYPE ty_matnr,
           range_table_matnr TYPE tr_matnr,
           range_table_bukrs TYPE tr_bukrs.

    READ TABLE it_filter_select_options
          INTO data(ls_filter)
          WITH KEY property = 'Bukrs'.
    IF sy-subrc = 0.
      LOOP AT ls_filter-select_options INTO data(ls_select_options).
        MOVE-CORRESPONDING ls_select_options TO workarea_bukrs.
        APPEND workarea_bukrs TO range_table_bukrs .
        ENDLOOP.
    ENDIF.

       READ TABLE it_filter_select_options
          INTO ls_filter
          WITH KEY property = 'Matnr'.
    IF sy-subrc = 0.
      LOOP AT ls_filter-select_options INTO ls_select_options.
        MOVE-CORRESPONDING ls_select_options TO workarea_matnr.
        APPEND workarea_matnr TO range_table_matnr .
        ENDLOOP.
    ENDIF.
    IF it_filter_select_options IS INITIAL.
      SELECT * FROM zekkoekpo INTO TABLE et_entityset.
    ELSE.
      SELECT * FROM zekkoekpo INTO TABLE et_entityset
        WHERE bukrs IN range_table_bukrs
        and matnr In range_table_matnr.
    ENDIF.

  ENDMETHOD.