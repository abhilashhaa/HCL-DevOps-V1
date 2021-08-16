  METHOD deserialize_data.

    DATA: lr_ref TYPE REF TO data.

    FIELD-SYMBOLS: <lt_data>  TYPE STANDARD TABLE,
                   <ls_table> LIKE LINE OF mt_object_table.


    LOOP AT mt_object_table ASSIGNING <ls_table>.

      CREATE DATA lr_ref TYPE STANDARD TABLE OF (<ls_table>-tobj_name).
      ASSIGN lr_ref->* TO <lt_data>.

      io_xml->read(
        EXPORTING
          iv_name = <ls_table>-tobj_name
        CHANGING
          cg_data = <lt_data> ).

      INSERT (<ls_table>-tobj_name) FROM TABLE <lt_data>.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Error inserting data, { <ls_table>-tobj_name }| ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.