  METHOD validate.

    DATA: lv_where   TYPE string,
          lv_primary TYPE objsl-tobj_name,
          lr_ref     TYPE REF TO data.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE.


    lv_primary = get_primary_table( ).

    CREATE DATA lr_ref TYPE STANDARD TABLE OF (lv_primary).
    ASSIGN lr_ref->* TO <lt_data>.

    io_xml->read(
      EXPORTING
        iv_name = lv_primary
      CHANGING
        cg_data = <lt_data> ).

    IF lines( <lt_data> ) = 0.
      zcx_abapgit_exception=>raise( |Primary table { lv_primary } not found in imported container| ).
    ELSEIF lines( <lt_data> ) <> 1.
      zcx_abapgit_exception=>raise( |Primary table { lv_primary } contains more than one instance!| ).
    ENDIF.

    lv_where = get_where_clause( lv_primary ).

*  validate that max one local instance was affected by the import
    SELECT COUNT(*) FROM (lv_primary) WHERE (lv_where).
    IF sy-dbcnt > 1.
      zcx_abapgit_exception=>raise( |More than one instance exists locally in primary table { lv_primary }| ).
    ENDIF.

  ENDMETHOD.