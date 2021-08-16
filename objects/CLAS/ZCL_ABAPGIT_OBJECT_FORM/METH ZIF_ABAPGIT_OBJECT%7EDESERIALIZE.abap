  METHOD zif_abapgit_object~deserialize.

    DATA: lt_form_data            TYPE tyt_form_data.
    DATA: lt_lines TYPE tyt_lines.
    FIELD-SYMBOLS: <ls_form_data> TYPE LINE OF tyt_form_data.

    io_xml->read( EXPORTING iv_name = c_objectname_form
                  CHANGING  cg_data = lt_form_data ).

    LOOP AT lt_form_data ASSIGNING <ls_form_data>.

      lt_lines = extract_tdlines( <ls_form_data> ).

      _save_form( EXPORTING it_lines     = lt_lines
                  CHANGING  cs_form_data = <ls_form_data> ).

    ENDLOOP.

    CALL FUNCTION 'SAPSCRIPT_DELETE_LOAD'
      EXPORTING
        delete = abap_true
        form   = '*'
        write  = space.

    tadir_insert( iv_package ).

    order_check_and_insert( ).

  ENDMETHOD.