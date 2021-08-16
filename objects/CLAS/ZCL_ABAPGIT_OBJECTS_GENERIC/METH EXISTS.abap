  METHOD exists.

    DATA: lv_where_clause TYPE string,
          lv_primary      TYPE objsl-tobj_name,
          lr_table_line   TYPE REF TO data.

    FIELD-SYMBOLS: <lg_table_line> TYPE any.


    lv_primary = get_primary_table( ).

    lv_where_clause = get_where_clause( lv_primary ).

    CREATE DATA lr_table_line TYPE (lv_primary).
    ASSIGN lr_table_line->* TO <lg_table_line>.

    SELECT SINGLE * FROM (lv_primary) INTO <lg_table_line> WHERE (lv_where_clause).
    rv_bool = boolc( sy-dbcnt > 0 ).

  ENDMETHOD.