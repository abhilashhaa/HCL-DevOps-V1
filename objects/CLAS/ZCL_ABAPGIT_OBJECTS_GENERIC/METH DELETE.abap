  METHOD delete.

    DATA: lv_where   TYPE string,
          lv_primary TYPE objsl-tobj_name.

    FIELD-SYMBOLS <ls_table> LIKE LINE OF mt_object_table.


    lv_primary = get_primary_table( ).

    LOOP AT mt_object_table ASSIGNING <ls_table>.
      lv_where = get_where_clause( <ls_table>-tobj_name ).
      ASSERT NOT lv_where IS INITIAL.

      DELETE FROM (<ls_table>-tobj_name) WHERE (lv_where).

      IF <ls_table>-tobj_name = lv_primary.
        ASSERT sy-dbcnt <= 1. "Just to be on the very safe side
      ENDIF.
    ENDLOOP.

  ENDMETHOD.