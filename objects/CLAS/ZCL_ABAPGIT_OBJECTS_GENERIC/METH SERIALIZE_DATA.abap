  METHOD serialize_data.

    DATA: lr_ref   TYPE REF TO data,
          lv_where TYPE string.

    FIELD-SYMBOLS: <lt_data>         TYPE STANDARD TABLE,
                   <ls_object_table> LIKE LINE OF mt_object_table.


    LOOP AT mt_object_table ASSIGNING <ls_object_table>.

      CREATE DATA lr_ref TYPE STANDARD TABLE OF (<ls_object_table>-tobj_name).
      ASSIGN lr_ref->* TO <lt_data>.

      lv_where = get_where_clause( <ls_object_table>-tobj_name ).

      SELECT * FROM (<ls_object_table>-tobj_name)
        INTO TABLE <lt_data>
        WHERE (lv_where)
        ORDER BY PRIMARY KEY.

      io_xml->add(
        iv_name = <ls_object_table>-tobj_name
        ig_data = <lt_data> ).

    ENDLOOP.

  ENDMETHOD.