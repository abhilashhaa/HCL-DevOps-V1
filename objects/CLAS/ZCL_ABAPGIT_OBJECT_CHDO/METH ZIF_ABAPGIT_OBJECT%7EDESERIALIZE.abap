  METHOD zif_abapgit_object~deserialize.

    DATA: ls_change_object TYPE ty_change_document.
    FIELD-SYMBOLS: <ls_report_generated> LIKE LINE OF ls_change_object-reports_generated.

    io_xml->read( EXPORTING iv_name = 'CHDO'
                  CHANGING  cg_data = ls_change_object ).

    DELETE FROM tcdobs  WHERE object = mv_object.
    DELETE FROM tcdobts WHERE object = mv_object.
    DELETE FROM tcdrps  WHERE object = mv_object.

    LOOP AT ls_change_object-reports_generated ASSIGNING <ls_report_generated>.
      <ls_report_generated>-devclass = iv_package.
    ENDLOOP.

    INSERT tcdobs  FROM TABLE ls_change_object-objects.
    INSERT tcdobts FROM TABLE ls_change_object-objects_text.
    INSERT tcdrps  FROM TABLE ls_change_object-reports_generated.

    after_import( ).

    corr_insert( iv_package ).

  ENDMETHOD.